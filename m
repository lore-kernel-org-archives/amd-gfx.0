Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B72C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 09:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6366410E9CA;
	Thu,  8 Sep 2022 09:10:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60ACA10E9CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 09:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iioHOIVz3uKjxzch1M1YKLhutpofaDqsRXil1eFsT0Bdc69ZhpmTwi+LtNioNXwuOM6pFBMo4GqriheRO1XHRJ3OAC4Qf0dSiCIbsHq55Y1+zwL3q+hBCkB5/f49BGjZfe5FxQ1DJa3WHAsuOCev8PcWivP4z3MWidjksATtrUd3KjgcPbyk3LOuN7ddBGxGlhgWECLgT5gejTE6vFI9HxErX5DN90mbg05UOFTPsme4Mu47ZcwfonIbYuNhodXPqNTN0BKwReWmsiNuTsw/SQ5TSH+pdhMnEg3qKqIjzGHZkldBTkSer/H4LNtJb1RIvzQgUrVPDzemDHwbcOJKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpOLPoWphJD3tvWhtICRXovPhxWwFpJYwQolvt/fRLw=;
 b=V40bafcZnviw41E0ZWxGiUCKD9lFUvCZqykQ+yY37Oyx5x7Mut16d4uN05Dt8C0G7SVJeIaBYWoyrDujlOLgxICn48mPrkxCjStdaSfLYHmaMNkjx0g1ayCTiGcRP7f2gDKstYKlej69PpCOq6nRsA/yXyMri9g7wQJo/n+U7BiASNoCdJYWdQKaNa4D0Y0mXtIe6hqbU93ORkzyfXX78dSZWy8e+SsGWuCqBUdwF+fqCkVfKgPE+REYz+NLInpxP+Wx74STYeajm5CEPpT8IyG2XJRRF1UUe00l56yx4Vr22A3wQIWf9Lxk1CAjDw/WjSQ5cSmu0m06uW9yMS0xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpOLPoWphJD3tvWhtICRXovPhxWwFpJYwQolvt/fRLw=;
 b=NE+SirceD/TYYrLLBHcQu9bkoaFWL7YU5F7G5ft+bRW+BcWtQ65HALOy+m/+5u3UdRrn7cV1Bkrsk4vWBvrtgGzOrf1QZ4TeZPG/4WJiAvP2GAPQiyNIdJEIODhCO89WjfEwVIQOX2MqRbsDUTo9AzK2ONT3IJeNXQ/2uOYxoj0=
Received: from CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 09:10:46 +0000
Received: from CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::cb3:21d0:6264:4614]) by CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::cb3:21d0:6264:4614%11]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 09:10:45 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable full reset when RAS is supported on gc
 v11_0_0
Thread-Topic: [PATCH] drm/amdgpu: Enable full reset when RAS is supported on
 gc v11_0_0
Thread-Index: AQHYwyAsLVqPMABI/kiOXPuamk/0bq3U5xYAgABYMhA=
Date: Thu, 8 Sep 2022 09:10:45 +0000
Message-ID: <CY4PR12MB14964A6111B93B57E9784CD491409@CY4PR12MB1496.namprd12.prod.outlook.com>
References: <20220908011035.17145-1-candice.li@amd.com>
 <4a97ca4d-8ca3-8143-43d1-8b4a33de675b@amd.com>
In-Reply-To: <4a97ca4d-8ca3-8143-43d1-8b4a33de675b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-08T09:09:58Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f643c58f-f4a8-42dc-aab4-e405bc35ba9c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-08T09:10:43Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 0eb16bd9-2f1b-49fb-a2d6-2831ab434068
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR12MB1496:EE_|MN0PR12MB5858:EE_
x-ms-office365-filtering-correlation-id: fd92d0cc-d4c1-4fa5-fe11-08da917a0335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FfSCNv6UG2eynOvzjLuf40X37DbZeTd7BLmoX1bSul9hpG+zxjENDG/7hOtws7MqhqsMKV736iTZSo3eRRijvpY5ZrQf671oolUwy1FPG2mRaY1p9Vife/2ksbLsUOmL92bhQdFqNUpOkdJvj0TuzfRuVU6EJlkVvVuXlqvMWbEI9MIYI99Rdft3RnMXAEMKPMY28HmzFVTm0gFcxvXrYYKCT37VQG1l5N5x3vc6tImtjzGuKoGh6S0Yj4mGMW2SZKkSVAiusk7xGFzWY/vFQWSlARP+YVLM6yRScbJyx5UvZ52ufjTN1rxChzrY0voeEaWc88jS+JPi2kj7+5i9TBreO2VMADhymZjgM0QVOVU84rrt23qjueDE0On7GN3iRUDAxOZJc2taMDRMQI/uxrxeHbA21+CRUtkLH96bUmNejGFv2njXXVBdoKuRgEvAGRFVGwB4AsGtoYP76hau16ADINekkW6AlZGxd+3oRxg/apn09j0ilAaLPM34FbYH8s2qOKW1w5FT8mntedzXq1WrVxoins0PQHRLTKCZ5DdqhzkmV+8fhDwHXvPKCIvCIs2pmePIYFnBqGzZw2ZU3sIts8zPqZYtd8e+JfZl1KHSPfzQ8+Sy0+YrEX93MT/KjU8IoMTmIASC76cc/8bv8n7SEU6gO0Jr0zrt+1gmWVucEV7mWguvoT/vA5/ocdpNYacq6z9zJDi9GXEQT4FBj2JrYpDqIkD9qIVAYzC14NOwIXE9jqLRhxmeJUtQ3nSNU1L1bdknLSAgWAuYpVcUVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1496.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(8676002)(66476007)(66446008)(76116006)(122000001)(64756008)(66556008)(66946007)(38100700002)(41300700001)(71200400001)(186003)(83380400001)(6506007)(110136005)(9686003)(7696005)(26005)(478600001)(316002)(2906002)(53546011)(86362001)(5660300002)(33656002)(52536014)(55016003)(8936002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlgvdG0vcFR6WWxNTWRPMTFRWnczQVJWZVJnMjVQWW1ienhWVFBxNWNzbkp5?=
 =?utf-8?B?dTg3NDlHVWFBMHR2WitWRFFCY1RpOVBXOHFjUStTbjNnTlNPaDQ5REJtOExp?=
 =?utf-8?B?S1VraU1VVElJeEo1a1dkRlIvUjl6ZHdNRkhscjRjaXdKeGFmeW13K2ROYzJy?=
 =?utf-8?B?R20wTy84WEFYQnRkejFFR3JHSkcwaDcxODdxYTc4cE5OWWFwcUNuK2UxOXF6?=
 =?utf-8?B?Zk1vdkxZQUcvOHpWR1hRUGw1ZWY1VmswQmVGdXVPcC96Sk9pbEx0aUdnTEFD?=
 =?utf-8?B?cDJicW8zTDVvVGNVNm9MbDRGSlNnamxtc1pON25xcG1scGNCcWpRbFY5aHJS?=
 =?utf-8?B?a3BZenpPTEowMDQ5STdqdVlLUC9kSGZjdFV6ZVBhUE15dlRLbll6MmFnNEZn?=
 =?utf-8?B?b2hPSWpqZUo4UWFZV3I5aUdFdWJ6Zlp2dGk3Rmp3dC9jcnVTbkoza29GcmFz?=
 =?utf-8?B?OUxWM2EydkdpelhWWjlyNVcyakFxZnUwcUhmRmloN1llVlREYktTcW04YWRZ?=
 =?utf-8?B?azU4Vk1ySzhQQWJXWGVDR3FsNnVjOWRic2xRcTZCbUduUVY0SGp3L0FBOWR0?=
 =?utf-8?B?UVZoOURnYVZtQTYxRjNaUk9qUDNteTFqcXhpV2NYMGpFY2NLWFEvYjFteG5Z?=
 =?utf-8?B?ZE1OTFR6UUpTcXMrbDlOUUg0S1ZQdE5IM1BKNmpMY1dWYmhNeEdQMlc1YVBO?=
 =?utf-8?B?Si9XME0vbUV3RG41UW9QMi9iQWkxTHE0SFVpbHFxYUNrcjFlaC9DaHJIbTRI?=
 =?utf-8?B?OXgvUEI1TVRGWE1ibm1GWmZuMTVxbDdKNzYvTXVZQWJCK1J5S1B4dTF2VUh5?=
 =?utf-8?B?SkdLTUR2OUNoOVo5a0NFU0dVQU5mTVBha1FRcGdnVkdTbS9SRW1ZRWM2bmtq?=
 =?utf-8?B?MXd3Y1ptaGNNeDB1MlZuc1RsMFRxWG1TdFoyTkVxSHYzZS93ZFZuM090SzBN?=
 =?utf-8?B?MlVCOGNaUU53QkpwcmVOY1g3RFhvUVpBQ1dOMGtyM3YrRFQ1STVkeGZWNHlR?=
 =?utf-8?B?WUJ4L1RiVUJvNGFTVzVjdmtPTnpnUFNuOWhGWlNhUkcwTFZWVWtNUDdnMDZw?=
 =?utf-8?B?TjZYdnRneEdYcitwaTM4TnMvclErQW9EZUoyNU4rSFFpNUY2UUdpQ01TRThp?=
 =?utf-8?B?UU5CdGwzQ2lBUkYzQldtTk9hR2h0RVdaYWRFS0F1Q1JtK25tWUwycnNobGl2?=
 =?utf-8?B?ckRNK09ZNStIbkp4NnNFZDc1MThubHZvQUdRb05xaGRHd3llUWQ3QlUvR1Z4?=
 =?utf-8?B?ZHg4a2VRcXlCM3Zwcmgzbm9XaVBraDVqcnQzeEdGMytrakhhamlPSTN0UkNH?=
 =?utf-8?B?WEE3dUZFblRhNkdmcVBHRFZhdmVlSURlUmx3OTNuNlB4K2xMN2o2d0ovdExu?=
 =?utf-8?B?ckRWdTRBNDc4OGk2U1lZQ21JQzFrbDhUenFQVGVicml2d0EwdjJHNlNqU3BR?=
 =?utf-8?B?NGcvL21jS2tyd2F6YlczK1Q2N29nTDhSbjFobzJjajBJdFhQb3Z1c3NLL2R6?=
 =?utf-8?B?eGNicnVxSHVYVFZiM2xBS0dnZlluZENEUG9HNGZ1MWVCRyszN2tuaFhWNXpZ?=
 =?utf-8?B?dDVjQ0xEY0FHdVFVekRDQmgvZGxISENqaHlYbVNvWU5EMzdmWGpjQWRQU0dC?=
 =?utf-8?B?QWpxTlZ0TnV0MjNWcEl1T3hFdXNUR3dZOFVFWWNzblpqTEUwaXMzQ3VDN2FO?=
 =?utf-8?B?RTA0YllvbCtCbmJCVjIxQUpVR29GREZLSHk3VG9vbzFBMythVmhpNTlNYUZP?=
 =?utf-8?B?MmlUNWlYa0RtSHltMGxXNnkyWFh3Y2JiM0ZaSUU3M1d3b09jNUxFeWhhUFJ5?=
 =?utf-8?B?K0VPQTVOangyYTcvdTFDbFZDelBYWW56aWhuMWxaTm5Qcm01cGtuU2ovbEVl?=
 =?utf-8?B?Q2YrNk01MXgwVWxhZDhwS1ZtYy8zTGxNWVpjbi9RWVFwRER4WktUWGxLajFp?=
 =?utf-8?B?d1hNaWpRdWh1L3c5cTFFTmpzR0VxVFVkeW5uV2Y0T1MvanNwVENFWmkxNnFK?=
 =?utf-8?B?QVQzZkIyOWxwQXdwOVNTaEt1cjhFSHRTZXRsQ0lGRTJxTzFOMXhTUjFDYlBP?=
 =?utf-8?B?NFYyb3ZrbUJtVGdpVGJDT0FSNENYRzlhdkdwcHY5bmlaZWhJWjNKOTBvOWQx?=
 =?utf-8?Q?4UJA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd92d0cc-d4c1-4fa5-fe11-08da917a0335
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 09:10:45.1785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8hVirCT5MAnnoRrfyR3O8lo1VRL2TqnZWmsXCfvRXwCfOz2/TcJD55UoQbUxzdX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkdvb2QgcG9pbnQsIHRoYW5rcyBm
b3IgdGhlIHJldmlldy4gSSB3aWxsIHNlbmQgYSBuZXcgb25lLg0KDQoNCg0KVGhhbmtzLA0KQ2Fu
ZGljZQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgOCwg
MjAyMiAxMTo1NCBBTQ0KVG86IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dTogRW5hYmxlIGZ1bGwgcmVzZXQgd2hlbiBSQVMgaXMgc3VwcG9ydGVkIG9uIGdjIHYxMV8wXzAN
Cg0KQW0gMjAyMi0wOS0wNyB1bSAyMToxMCBzY2hyaWViIENhbmRpY2UgTGk6DQo+IEVuYWJsZSBm
dWxsIHJlc2V0IGZvciBSQVMgc3VwcG9ydGVkIGNvbmZpZ3VyYXRpb24gb24gZ2MgdjExXzBfMC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogQ2FuZGljZSBMaSA8Y2FuZGljZS5saUBhbWQuY29tPg0KPiAt
LS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jIHwgNCArKysrDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzIxLmMNCj4gaW5kZXggYTI2YzU3MjNjNDZlMjcuLjgxZjMyZDc3Yzk4Y2Q1IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gQEAgLTQyMSw2ICs0MjEsMTAgQEAgc3Rh
dGljIGJvb2wgc29jMjFfbmVlZF9mdWxsX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQ0KPiAgIHsNCj4gICAJc3dpdGNoIChhZGV2LT5pcF92ZXJzaW9uc1tHQ19IV0lQXVswXSkgew0K
PiAgIAljYXNlIElQX1ZFUlNJT04oMTEsIDAsIDApOg0KPiArCQlpZiAoYW1kZ3B1X3Jhc19pc19z
dXBwb3J0ZWQoYWRldiwgQU1ER1BVX1JBU19CTE9DS19fVU1DKSkNCj4gKwkJCXJldHVybiB0cnVl
Ow0KPiArCQllbHNlDQo+ICsJCQlyZXR1cm4gZmFsc2U7DQoNCklzIHRoZXJlIGEgcmVhc29uIHdo
eSB0aGlzIGNhbid0IGJlIHdyaXR0ZW4gc2ltcGx5IGFzDQoNCiDCoMKgwqAgcmV0dXJuIGFtZGdw
dV9yYXNfaXNfc3VwcG9ydGVkKGFkZXYsIEFNREdQVV9SQVNfQkxPQ0tfX1VNQyk7DQoNCg0KUmVn
YXJkcywNCiDCoCBGZWxpeA0KDQoNCj4gICAJY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAyKToNCj4g
ICAJCXJldHVybiBmYWxzZTsNCj4gICAJZGVmYXVsdDoNCg==
