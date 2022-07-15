Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CB4C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 09:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC1011B587;
	Fri, 15 Jul 2022 09:28:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED5E11BD09
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 09:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPWN6C3ku7ZxLsmYU6PuoUScZ8GqNIrHB95BKYSXvZzkVgCS63tGB9swOGpqTbp1cjihB/3AGkxVy+ZnYRC6dSfEblTscb6z+8QesbGySaZ+OfTOF8oE3veoiDCeeezyOhzNIlkSDjmPeWOtoH9Unn44Xu1etTw5pn6JAbW7rwOMkgFKAx1WRxmu2z/cY1x8EKgBpZJc4Fg4RIX8dyu377DZxXCDD7vO2hY8ngFtm61rcdQETwni2KF8YCV+j7BT3RVwkCxxExdKgwoWb84Bz/KICQWt6EUp1POE+4Mt4+MpO3ixWiEtFJIM3eijVMGbFsZ3gl42B3Vv7xrB8/TRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muSt2mn7nwy/JJCABX5X+95XbqDQId2lgfOB6XBfy2M=;
 b=FEmdmRUCi9VXOe14xpb+4G5uB7SQTFBRhiEr48+coixs7T4WmVCh9q9jhXiQWCZ3K9O0tohdo/DLW/OIneU1jltn3ujWSFIayrgL3zDc5iw8gtkyP2ktQCzbCMrT9zC+nJQoo58ycXDlEqYVhok153G30V1zOxrZiDFtlF0HgXl7oQJDzf01yfQNM/0SLvpaWOmStSXSrOKRlxmpXe7pbcaZsTlxroFTLcOOBapcPeMsluGFyS3uGpCCycSLO+QlH5lV+B6B7ucCGnjhPbyxotIp04ZZ1AXu6qe92fyeQs5sg+TlPZPYzqUfre9oxWaq2MgYLnp9VYkNAr+YAHeeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muSt2mn7nwy/JJCABX5X+95XbqDQId2lgfOB6XBfy2M=;
 b=VNHLf9fIfHL84XiVsSZXAED4LuQoSCL46lXoYk21z3MAhojORSj2tQJsrIpisBs5mi7+PDK3744d5Db1ZnXJI4c54ZgF1AkqB5SNSeCESVcgYsAaR8l61FSiKpO9OsqPJjNUZiyqRJQpuaEPRCeJKEuIOQpI5PZ9z05xyEFvvOk=
Received: from SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 by BN8PR12MB2931.namprd12.prod.outlook.com (2603:10b6:408:6d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 09:28:01 +0000
Received: from SJ1PR12MB6338.namprd12.prod.outlook.com
 ([fe80::806:413a:10e8:9798]) by SJ1PR12MB6338.namprd12.prod.outlook.com
 ([fe80::806:413a:10e8:9798%9]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 09:28:00 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Grodzovsky, 
 Andrey" <Andrey.Grodzovsky@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
Thread-Topic: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
Thread-Index: AQHYmCcnHjbzdqK0x0edZhRsQVxzkK1/HvEAgAABp/CAAAekoA==
Date: Fri, 15 Jul 2022 09:28:00 +0000
Message-ID: <SJ1PR12MB633848FACEAA771E018BAA0EF48B9@SJ1PR12MB6338.namprd12.prod.outlook.com>
References: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
 <20220715084356.427458-3-Jiadong.Zhu@amd.com>
 <7ca91143-9da1-4fc4-0cde-268705764e42@gmail.com>
 <DS7PR12MB633367D703FBDC999E8B7E79F48B9@DS7PR12MB6333.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB633367D703FBDC999E8B7E79F48B9@DS7PR12MB6333.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5ee88fed-cf13-486d-8d2d-916b4e297bf3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-15T08:54:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92fddc20-4520-4bb1-0901-08da66444fa7
x-ms-traffictypediagnostic: BN8PR12MB2931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ns44fqvw1cp402XNR5uH2aVWgXDwGBg0mztpxMeptZWBoheycszcUwVY8W5N2L6fc2wNr3Y7rd5t2JvyYS2vgq1EhGOBYFa1WlCHcqetuHozV4ajBmKm0UHqzUD7fBjYY3B2GADfgRMX9DN/Q5k45atloZqHbAUYyw9qzmrrO7GgwIo1X0eHUG5vJTTrb3c9JKBYGdPfoZY62P/0XbNMR5SeGtujNAzfVnEKNm8TfeJPJp1tPY6y7uNSW3Fk7wtTOm/7rkCgeJkkqsrlWkCHefPpTrSf3Wgctvg0pTiIc48Py5ZX8fKVcDmcyJxj5f/ZDLETvpKyki21CfEsL5p6nOZ8W8UCQw2mmSm+1P21zJ3vil8sHJLUUVPG0FveYWeiqTqrzk2t+Ilw7+JknsXCwJUUEPeRteUSamMo9I7McfSOGUFdj1ALDgcNu5pWkRQCVrVMPPHi8tCJJia+DNR9rDTtacZmB+06cwROOW5V8MAUVxIlVHfXYPc/Iq7lKj+c7bXWWs3tQzzIEjueQ0TCudizYihGblhCb+JqgaeCCMGKacX6l+PZR40k2TzNLp1E494/PpRTclZ8WYKu+SWjHdXCUGcbWxyp3c69dzz5GRnaWA+yugbjoiQoQj0ylM/brpwpo4+dHmHTVnCK1L29jt8LhcwJ+2rg8LI/5kb6pTHKzKvq9KOkDDK7Bw36REZWbA2WcRMGL4WPiMPpMfN0q+77I/vC/ac2uadHPhjvoIqAMgQMYboTuM8fetcERAZgKNY08YiLQSek+Gg9d+BZNOfmeUYg9XeYug1MD6xYigfTS+kfgJaX9fwHiulvef1Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(6506007)(53546011)(7696005)(55016003)(6636002)(33656002)(26005)(110136005)(9686003)(54906003)(316002)(478600001)(71200400001)(41300700001)(4326008)(66446008)(66556008)(76116006)(52536014)(66946007)(64756008)(8676002)(122000001)(38100700002)(66574015)(66476007)(83380400001)(38070700005)(5660300002)(8936002)(86362001)(2906002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVNaSk03bXBram9FWlJidFVmQ1kzd09aM1VubTMvaDZMWWNUemNlWHlTUzV4?=
 =?utf-8?B?clJCSGNzdTdaOGlmbDhZcFBuN0tnRVQ5NUhtczBnTDhuNzlNQVZURmJZN0R3?=
 =?utf-8?B?RmNnanRXY3J0K3lKNndoaTRwZ2lycXM5T0JJQjNGdURzaG9XdVV3MHExUDdq?=
 =?utf-8?B?TnpVN0NhSmVlYUp4bzNEY0hpeE5vcjV1aWJHYUw3SDdJQnMwcmpIVUdIR2Vo?=
 =?utf-8?B?Q2dPcURVd3d6U1hKb0x5Y01MaFFzRW9Jc3J1ZVI2TWcrUC81N0R0a0pOQXc1?=
 =?utf-8?B?SjNJUHRxSzJ6QU55SmFVeDZPWmZieG5LWVlvM2ZkMWM2ZCtFb1dLUFYySUho?=
 =?utf-8?B?NWVodE40dFZJRUNFbDJuMTZRT2tGUUlqWU14UGk1aXlBUEJDR2tmYTlMWnNO?=
 =?utf-8?B?WWNuTmJZTGRkZEhwVERSclJaNzVxaklzbGdwZWl6bUwvZnYyRGdQSmZBdWRh?=
 =?utf-8?B?SzZKQTJZUXZyQUg4aFl2czVMUllJa2lzbGFoa0tiZWpYTnFGeDlGc1AxSVhJ?=
 =?utf-8?B?QWpZbG5rWTA0U0tkNUhpdnZxWjBKbExDT2NwTUhFbGZBd20xMmVmdWN6alVo?=
 =?utf-8?B?SllsZ25tUTdYQmp3ZkpIbDhTSlpJNjdqdUxvNkl5NjV2cDJMc25BcW5wVGxX?=
 =?utf-8?B?SGFWS3AzRk5jcCsvVnVBL1RleWFkWHczUWZncEFMcW1LS2FtRnZWcVB1Y0tR?=
 =?utf-8?B?RHFIQytua1V3T2pHdkRVdGlUTmpBSFU2bnp1UVFNNGErRlBRdmdZbVBzc2xo?=
 =?utf-8?B?SCtjdFBSSFlVRFJuMG0rTEV1WVlrU3RXUkNBRm5WUHJTQ2l1Wld2cXM1czdy?=
 =?utf-8?B?Z1dFdWZ5c1RVSk4wZk1hamQ1bk1tYy9BRW1vejExOFFST3JLd3dpdWFHZGtE?=
 =?utf-8?B?TjBCSkM5VU1jaVB0SWRZbmNjOUtobEs2SnhYaG9qR2JWNGZoajR1NndxeHEz?=
 =?utf-8?B?ejR1UVdnMVN5aFFyQXR4NFJPYm93L09aM2xQd0w2eE84VHc1Tk54cUMwQnlL?=
 =?utf-8?B?R201ZnQ1YTd5TE93Z3NaNE82M05UbXlCTFlwTTBEdHZ2Y2JjTzRKOUhqeWZn?=
 =?utf-8?B?b2ZNZkRLWjNiZURjcVo5OTduRjY5QmJpVGt6OGNVVDVCdTFuc29zTHdGbkwy?=
 =?utf-8?B?TzBSbDE0QmRwUGJpRERXZE9TQ2wrc0VmajgzMk9hbGdlcXAxc1RvOEQvZzRP?=
 =?utf-8?B?RzkxOTJnUFNzUzBqR0s2bFpSdll5c3FaTUdkcTJBSmlCUlIzcFFpUkUyUmZl?=
 =?utf-8?B?QWh4RmR6TklUSE56MWRYZDlDc25WS0dlNElVcW0wSkFWNnQ2alpWMUZLWlVC?=
 =?utf-8?B?T2RWWkM3ZXNlWXV5MkRLQXJUcUFINlBKd0hXa3VVa1BDQzVHYUtSRWhIYjZ4?=
 =?utf-8?B?SCtPOWJGVG1WTzhmeWdHdkV5YnZ2bEkzcE8zNzZYeTRHdlJRZUM0eDNWZkpV?=
 =?utf-8?B?UlRTTzBsSzFiTXN2dHl2bmdpMHBiNG1BVzA3bnB3U3FLbno4ZjNCTHB1NzZi?=
 =?utf-8?B?bjJzUGVxckpXYVo2SVhRbTg3Wmg2cHA0Nnl2UGIxb295c2dCcGNKUVRYMGFE?=
 =?utf-8?B?bVFZaFlwZnFYN2wxbVpqVEZ0eHRSd1hJQlVQUW1xeWc5NFh2andRQlB5VGo3?=
 =?utf-8?B?ekcyQnE2ak9CNWFKTndBYlVrSnZOUkZ5dVJDbFNHcEtvbnFYcWNrV2lmRjhF?=
 =?utf-8?B?Yy9IcjlKVVYrWGo3b2RobEhzUStjeldiT1NTVU5UQ1dNSjI2a1EvZ0FzYjlI?=
 =?utf-8?B?c1psalNDWEVZSFh3Nmp0TW9xVTRQSWcyQnBUTVVQa0lSYzFhTTR4TXlWcm5V?=
 =?utf-8?B?V05STXQwY3FHMHRQVEZBbGFUbWtxV1lKS2NpRytBbE9mYkpOSTNmNGtWaXVz?=
 =?utf-8?B?VUpycGdaRDZrRVNvWE9IUHliL2pydGpaMFVKeGk4ZnpBT3pnUHB1bnM1eFNr?=
 =?utf-8?B?UTMvUE1XYU9vc05FMnZDbFpoc2wxUVJWNzZ5cVlFY0hnWDlxTEk0clhuWEdu?=
 =?utf-8?B?RmR5NTRDRVBYT2JuL3B6SSs0OXZ5c011SXdFRWhlMzVLcXhGcU5EemsrWGsx?=
 =?utf-8?B?dG55cWtwUTJCVERxZDc5aWpQRkVlQndEK3NsaG10aXdWK2RzbU40QkRtT0pH?=
 =?utf-8?Q?Pezc/p1TUCuZuSLfMK2iMP0yU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fddc20-4520-4bb1-0901-08da66444fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 09:28:00.6034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vwh9pB+vAhQjmsqyZGm934JX7byHmls2KCjjxkrrpUpdoOMlzT5q7+FH70Z+iimLShl5S06X20+qqA8gmHUSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2931
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClVwZGF0ZWQgc29tZSBjb21tZW50
cw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmh1LCBKaWFkb25nDQpTZW50
OiBGcmlkYXksIEp1bHkgMTUsIDIwMjIgNToxMyBQTQ0KVG86IENocmlzdGlhbiBLw7ZuaWcgPGNr
b2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4NCkNj
OiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IExpdSwgQWFyb24gPEFhcm9uLkxpdUBh
bWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCAzLzNdIGRybS9hbWRncHU6IHNraXAgcHV0IGZl
bmNlIGlmIHNpZ25hbCBmYWlscw0KDQpIaSBDaHJpc3RpYW4sDQoNClRoZSByZXN1Ym1pdHRlZCBq
b2IgaW4gZnVuY3Rpb24gYW1kZ3B1X2liX3ByZWVtcHRfam9iX3JlY292ZXJ5IHJldHVybnMgdGhl
IHNhbWUgaHcgZmVuY2UgYmVjYXVzZSBvZiB0aGlzIGNvbW1pdDoNCg0Kc3RhdGljIHZvaWQgYW1k
Z3B1X2liX3ByZWVtcHRfam9iX3JlY292ZXJ5KHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2No
ZWQpIHsNCiAgICAgICAgc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iOw0KICAgICAgICBzdHJ1
Y3QgZG1hX2ZlbmNlICpmZW5jZTsNCg0KICAgICAgICBzcGluX2xvY2soJnNjaGVkLT5qb2JfbGlz
dF9sb2NrKTsNCiAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShzX2pvYiwgJnNjaGVkLT5wZW5k
aW5nX2xpc3QsIGxpc3QpIHsNCiAgICAgICAgICAgICAgICBmZW5jZSA9IHNjaGVkLT5vcHMtPnJ1
bl9qb2Ioc19qb2IpOyAgICAgICAvL2ZlbmNlIHJldHVybmVkIGhhcyB0aGUgc2FtZSBhZGRyZXNz
IHdpdGggc3dhcHBlZCBmZW5jZXMNCiAgICAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KGZlbmNl
KTsNCiAgICAgICAgfQ0KICAgICAgICBzcGluX3VubG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2sp
Ow0KfQ0KDQoNCg0KY29tbWl0IGM1MzBiMDJmMzk4NTBhNjM5YjcyZDAxZWJiZjdlNWQ3NDVjNjA4
MzENCkF1dGhvcjogSmFjayBaaGFuZyA8SmFjay5aaGFuZzFAYW1kLmNvbT4NCkRhdGU6ICAgV2Vk
IE1heSAxMiAxNTowNjozNSAyMDIxICswODAwDQoNCiAgICBkcm0vYW1kL2FtZGdwdSBlbWJlZCBo
d19mZW5jZSBpbnRvIGFtZGdwdV9qb2INCg0KICAgIFdoeTogUHJldmlvdXNseSBodyBmZW5jZSBp
cyBhbGxvY2VkIHNlcGFyYXRlbHkgd2l0aCBqb2IuDQogICAgSXQgY2F1c2VkIGhpc3RvcmljYWwg
bGlmZXRpbWUgaXNzdWVzIGFuZCBjb3JuZXIgY2FzZXMuDQogICAgVGhlIGlkZWFsIHNpdHVhdGlv
biBpcyB0byB0YWtlIGZlbmNlIHRvIG1hbmFnZSBib3RoIGpvYg0KICAgIGFuZCBmZW5jZSdzIGxp
ZmV0aW1lLCBhbmQgc2ltcGxpZnkgdGhlIGRlc2lnbiBvZiBncHUtc2NoZWR1bGVyLg0KDQogICAg
SG93Og0KICAgIFdlIHByb3Bvc2UgdG8gZW1iZWQgaHdfZmVuY2UgaW50byBhbWRncHVfam9iLg0K
ICAgIDEuIFdlIGNvdmVyIHRoZSBub3JtYWwgam9iIHN1Ym1pc3Npb24gYnkgdGhpcyBtZXRob2Qu
DQogICAgMi4gRm9yIGliX3Rlc3QsIGFuZCBzdWJtaXQgd2l0aG91dCBhIHBhcmVudCBqb2Iga2Vl
cCB0aGUNCiAgICBsZWdhY3kgd2F5IHRvIGNyZWF0ZSBhIGh3IGZlbmNlIHNlcGFyYXRlbHkuDQog
ICAgdjI6DQogICAgdXNlIEFNREdQVV9GRU5DRV9GTEFHX0VNQkVEX0lOX0pPQl9CSVQgdG8gc2hv
dyB0aGF0IHRoZSBmZW5jZSBpcw0KICAgIGVtYmVkZGVkIGluIGEgam9iLg0KICAgIHYzOg0KICAg
IHJlbW92ZSByZWR1bmRhbnQgdmFyaWFibGUgcmluZyBpbiBhbWRncHVfam9iDQogICAgdjQ6DQog
ICAgYWRkIHRkciBzZXF1ZW5jZSBzdXBwb3J0IGZvciB0aGlzIGZlYXR1cmUuIEFkZCBhIGpvYl9y
dW5fY291bnRlciB0bw0KICAgIGluZGljYXRlIHdoZXRoZXIgdGhpcyBqb2IgaXMgYSByZXN1Ym1p
dCBqb2IuDQogICAgdjUNCiAgICBhZGQgbWlzc2luZyBoYW5kbGluZyBpbiBhbWRncHVfZmVuY2Vf
ZW5hYmxlX3NpZ25hbGluZw0KDQogICAgU2lnbmVkLW9mZi1ieTogSmluZ3dlbiBDaGVuIDxKaW5n
d2VuLkNoZW4yQGFtZC5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogSmFjayBaaGFuZyA8SmFjay5a
aGFuZzdAaG90bWFpbC5jb20+DQogICAgUmV2aWV3ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxh
bmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0KICAgIFJldmlld2VkIGJ5OiBNb25rIExpdSA8bW9u
ay5saXVAYW1kLmNvbT4NCiAgICBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQoNCg0KVGh1cyB0aGUgZmVuY2Ugd2Ugc3dhcHBlZCBvdXQgaXMg
c2lnbmFsZWQgYW5kIHB1dCB0d2ljZSBpbiB0aGUgZm9sbG93aW5nIDIgZnVuY3Rpb25zIGFuZCB3
ZSBnZXQgIiByZWZjb3VudF90OiB1bmRlcmZsb3c7IHVzZS1hZnRlci1mcmVlLiAiIGVycm9ycyBs
YXR0ZXIuDQoNCiAgICAgICAgICAgICAgICAvKiB3YWl0IGZvciBqb2JzIGZpbmlzaGVkICovDQog
ICAgICAgICAgICAgICAgYW1kZ3B1X2ZlbmNlX3dhaXRfZW1wdHkocmluZyk7IC8vd2FpdCBvbiB0
aGUgcmVzdWJtaXR0ZWQgZmVuY2Ugd2hpY2ggaXMgc2lnbmFsZWQgYW5kIHB1dCBzb21ld2hlcmUg
ZWxzZS4gVGhlIHJlZmNvdW50IGRlY3JlYXNlZCBieSAxIGFmdGVyIGFtZGdwdV9mZW5jZV93YWl0
X2VtcHR5Lg0KDQogICAgICAgICAgICAgICAgLyogc2lnbmFsIHRoZSBvbGQgZmVuY2VzICovDQog
ICAgICAgICAgICAgICAgYW1kZ3B1X2liX3ByZWVtcHRfc2lnbmFsX2ZlbmNlcyhmZW5jZXMsIGxl
bmd0aCk7ICAgLy9zaWduYWwgYW5kIHB1dCB0aGUgcHJldmlvdXMgc3dhcHBlZCBmZW5jZSwgc2ln
bmFsIHdvdWxkIHJldHVybiAtMjIuDQoNClRoYW5rcywNCkppYWRvbmcNCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6
dW1lcmtlbkBnbWFpbC5jb20+DQpTZW50OiBGcmlkYXksIEp1bHkgMTUsIDIwMjIgNDo0OCBQTQ0K
VG86IFpodSwgSmlhZG9uZyA8SmlhZG9uZy5aaHVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5j
b20+DQpDYzogSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBMaXUsIEFhcm9uIDxBYXJv
bi5MaXVAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBkcm0vYW1kZ3B1OiBza2lw
IHB1dCBmZW5jZSBpZiBzaWduYWwgZmFpbHMNCg0KW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0K
DQpBbSAxNS4wNy4yMiB1bSAxMDo0MyBzY2hyaWViIGppYWRvbmcuemh1QGFtZC5jb206DQo+IEZy
b206ICJKaWFkb25nLlpodSIgPEppYWRvbmcuWmh1QGFtZC5jb20+DQo+DQo+IERtYV9mZW5jZV9z
aWduYWwgcmV0dXJuaW5nIG5vbi16ZXJvIGluZGljYXRlcyB0aGF0IHRoZSBmZW5jZSBpcw0KPiBz
aWduYWxlZCBhbmQgcHV0IHNvbWV3aGVyZSBlbHNlLg0KPiBTa2lwIGRtYV9mZW5jZV9wdXQgdG8g
bWFrZSB0aGUgZmVuY2UgcmVmY291bnQgY29ycmVjdC4NCg0KV2VsbCBxdWl0ZSBhIGJpZyBOQUsg
b24gdGhpcy4NCg0KUmVmZXJlbmNlIGNvdW50aW5nIHNob3VsZCBiZSBjb21wbGV0ZWx5IGluZGVw
ZW5kZW50IHdoZXJlIGEgZmVuY2Ugc2lnbmFscy4NCg0KQW5kcmV5IGNhbiB5b3UgdGFrZSBhIGxv
b2sgYXQgdGhpcyBhcyB3ZWxsPw0KDQpUaGFua3MsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVk
LW9mZi1ieTogSmlhZG9uZy5aaHUgPEppYWRvbmcuWmh1QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA0ICsrLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gaW5kZXggZjRl
ZDA3ODVkNTIzLi45M2MxYTVlODM4MzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiBAQCAtMTUwMCw4ICsxNTAwLDggQEAgc3RhdGljIHZv
aWQgYW1kZ3B1X2liX3ByZWVtcHRfc2lnbmFsX2ZlbmNlcyhzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVu
Y2VzLA0KPiAgICAgICAgICAgICAgIGZlbmNlID0gZmVuY2VzW2ldOw0KPiAgICAgICAgICAgICAg
IGlmICghZmVuY2UpDQo+ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gLSAgICAg
ICAgICAgICBkbWFfZmVuY2Vfc2lnbmFsKGZlbmNlKTsNCj4gLSAgICAgICAgICAgICBkbWFfZmVu
Y2VfcHV0KGZlbmNlKTsNCj4gKyAgICAgICAgICAgICBpZiAoIWRtYV9mZW5jZV9zaWduYWwoZmVu
Y2UpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQo+ICAg
ICAgIH0NCj4gICB9DQo+DQoNCg==
