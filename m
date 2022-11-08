Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCCFC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 01:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF7010E3FF;
	Tue,  8 Nov 2022 01:41:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B94FA10E3FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 01:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BATq1mCNoqUdtJA1pOzzTuOi0pyU05GxAGVfwvBOso1JHKZ8BPqzxh4qaGKsyL85nB186ehtYTcsGfTTcEFt8P5oNHMZ6fjraMW53aH6r0hg+mJ0TcVmLuYuRGZH6xb69/QkUk2Gnf8W5vhnbYsJYJaXeNP7T/vs5jmhjhpOmQEHEPjA353faO5PvH5syKghuHHyjBuxCBITJrAREzfml6SUpC6YwWSUPnMuOQzexN2oXuEqGiD6+vOxB2kITel3BlbZTkV9OLvxIqYR2ZUAqFeZvfsnOwaPJ8LL8AReOhX59R4ZCdKZAugsije+oe3tBq926s4XxxEAezV20K3/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUdHfUigfz9OmYrdIxI7oliRrTQOnwgAO7gQZcHKR/8=;
 b=lRW/ZPwse8b64126oFDcxxNUCFVbgtjB+XZxt08H9qDGPmaraJbSEd7JJZ/RX/DjiVjjMfdVzxLnOi6LwTrRPqJbQnO6iyn9j0nkyRigzofXufpzNPlLnWObAzIlE0j6OUGTBqfPC2eNRCqxCAl0Bfhg21HQWTXe8Ew5oo6GrIER8eBQd3fw6lXTxC8N9p7UiAlIoCEAJIryrdUXXns4hO5HwYIhzJw35TFJZYAIXhLYlAaqUy/MJAY6iAmCDSTB7z2AuvfobGZIpXP0hg24u/KABdcUhCbtWwTQvS4H5DqydOoqLKoijC9nB21jztm5RYKS0PsLi+echx37Opb38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUdHfUigfz9OmYrdIxI7oliRrTQOnwgAO7gQZcHKR/8=;
 b=NAMek7NtPRHpu5v/C7Y04dNTCu0zyRllgSHuCq33c5Bs54YI/hzbdbj6jEnWH+P5/5wqTYe+YBatDsoAaMYfOG54hzKFvRXkk5hQWj3CbpRrywGOfylrb5Q2J+sM2UpLKSbL2PDhrPU44MfbK0PLmjvgPbBhWiwuWjX4do8gxWI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 01:41:36 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::b9c7:c610:de5a:d73]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::b9c7:c610:de5a:d73%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 01:41:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/pm: enable mode1 reset on smu_v13_0_10
Thread-Topic: [PATCH v2] drm/amd/pm: enable mode1 reset on smu_v13_0_10
Thread-Index: AQHY8woWJzsyhyjBmUuxbvfzWbEqbq40PqNM
Date: Tue, 8 Nov 2022 01:41:36 +0000
Message-ID: <PH7PR12MB59970E86C206C20D162DE293823F9@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20221108003543.2912161-1-kenneth.feng@amd.com>
In-Reply-To: <20221108003543.2912161-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-08T01:35:18.5647581Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB7523:EE_
x-ms-office365-filtering-correlation-id: 63ee45f5-d309-4f51-4c7e-08dac12a5f96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F6BAgh5sy79BiHpwgJjj4Z93pIWGgN/G/eMlql2FAm25D8bOULRkRSuQol2jRWhY3DNkVKyZ5ywt2WLclY+Y6v2Ki1G/FiRM0gVh/Uh7NY4letEv9nLXof2gF2pkfIWI+UsUdG0bsXCWtGotuZJfXm36w0T4ConUulzCiArZS9XDGTPCzVf3hzPgoKHlVweCSCdncLerq+pIdApwqIIx72Ud9s5H+r2VGf493RumQxRa4O0H7wJmA7YndvsP/JOo9Oimh/1QZ+vhDUVxS1bxAUyM+PXz0dmVSBhf39CscOOhWJ7rZ3PAv9iHfu6DLd6CdFrEI/c04nEJ7IHre5Ee4TFyghjn7jGXdS0VAyo9kSjBaw9m+P/JXwx5Sj4+AIMKfrhp94eYSHLLDDYYWg2rIyPU1i9Z6dn7sZsM3EkYKQfMNWwATY4XZvMb3aEckavH8eWfejeXunpYMHdcZIVCo2fVtu1nDeuPhyYN8kIy6ui0EZ2N8Yb/puvbHwpMdWx1qAob0F+5C652GW49aaRV3RRPYoAUBBGSX26reBfrWoVdiHeqWh41GQ/bpbEBTaxV6yPb4UETOgD3Y12yUfXjuVoLQBo75a8oxEWiPAU1k7eNbCWXr2AxDaFwOotL2BgumEkqroAkHuciFbN0ctHu6+Sz9jqrn7CIHKO92AEjkZ56Y3Iy2tvIzUqGAyL664eZTLrusWzqgRKrwPg75lmV1q7INjiaOWuxS5KdPnOBlS4s/2t3/meHv+gNjS2hPuPXbTGtX9PLR1A9Ncw77DP05Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(478600001)(66556008)(91956017)(316002)(76116006)(9686003)(33656002)(4326008)(2906002)(66476007)(41300700001)(64756008)(8676002)(52536014)(66446008)(5660300002)(66946007)(71200400001)(55016003)(110136005)(8936002)(38070700005)(83380400001)(38100700002)(6506007)(122000001)(7696005)(86362001)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Zk0xbWlKdTdWdEtTeDNnbHVqNkQ5QjFOanU1ZEVqTVp1eGl5NDRBcEZUY3ZC?=
 =?gb2312?B?Qng2eUdCY1Raa3ltTFh5NGFwR2ZBNXg3OVphL2VsYUxuR1hpQ2NiYTJTK2FW?=
 =?gb2312?B?Wjd1aU84YWxxQ3lMbEpnZ3YyMUNRTVhQSXNvVmEwd0NtTnltcEN1NjltYWx6?=
 =?gb2312?B?Vml4clIrNERDUE5MSmsvbzMzYjJYTEh3b2VjRjFtRTErRityemRlb1I1cjBX?=
 =?gb2312?B?TjZqVkVHOTgrRTdseHlxSTRQZ21YUURRQXNra05zbGxHTE81V0d5WTczdFlj?=
 =?gb2312?B?S2wrM0lObUxlTmxEK25VTDhVSGdoMUlYMVBiTEFWUGJDazh6WkhWNWJySEhF?=
 =?gb2312?B?UmpJSTRTcE1JQU1LWHhIZ0xaZ25ldnhwWDdycXFSKy9tYzZPd3c3cVpLMnVv?=
 =?gb2312?B?S00wODZmQURTOWhNSjgrWW1SOCtleC9rS3F3akRjb0FMMDQyV3VobVA3Q3dM?=
 =?gb2312?B?bldUM2NyamRHdm5MU054RDRsbWlRVWlNSmJxVXlqK1I5OXl0dlc1RzVXRUI3?=
 =?gb2312?B?Z3BMcEFlWUpjbGRTbE43cTFNK1ZRQTlVOUt5TW9yMzJxWW5sb3hVRStyM3hW?=
 =?gb2312?B?RzNDZkgzdDd0anJ0cnE2UWxBelRoNnlBTldPQWdvUVNnK1VWdkFUQ1FXWXVn?=
 =?gb2312?B?YlplR2VFaGR5eXdZMURkbVgrcGpvbml1bGFubk13MzZYZE0zakQzQktqN29u?=
 =?gb2312?B?WHlZR0pnbmFDeWpzYkFFcDRvYWtCTFovNmRCYW85cXN0MXpWQm4vbndNQTBZ?=
 =?gb2312?B?bzVSczk5R1RjWXNtVnV5bUNTdnFIMklhZzZ5OFBYWXRVSG04WU40U1NIMC9S?=
 =?gb2312?B?VENNNGVZNGxpVzdBRzN0ZEZvZVorVjdKRUFmL2hQN2xoNU04Um1zU3Z0Wlg0?=
 =?gb2312?B?NWJLaXhkT2lnVWhDWWViUFhpbWt6VVZtUllYQmFUU0VNT08wTlVObUNWMFZL?=
 =?gb2312?B?YmFMSmxsYXZIdjR5Q2tLQVJ2S0FXTEZOREJHRGpTVEdJV2FzNjlieGRJcndh?=
 =?gb2312?B?R3NRbHZ1WmFxQTJTV2ROdGtqK2w3UlJpQitKTFhmSHNmWjNKQUF2eThKdXVz?=
 =?gb2312?B?Sm5ZSjlyMmFvd1pBL2NmTVlsREk2TlJLdnVyQUNtdTkwQjRrS2d2RldsbHNP?=
 =?gb2312?B?Z0QxZDVuR0VrRGp6LzlYbUprWDRxVGtubkpDanJ0QlNVNzRlQ2JoQmdjd25l?=
 =?gb2312?B?dkc4QU9rN1NRVUF6cDFuYldyckpYUzFxcDdSRzdDaS9OVFZJK2ZiSnRhcStl?=
 =?gb2312?B?Y3JBenU4R2tEdVFHYlZ0aEVUN29sa3l0RG1DMENqY1c2bGRIUHhjazBSWlpi?=
 =?gb2312?B?UzlSRURZKzVvN0dwa3B6cG9zQU9rVHZHWFlMVjVieEx3WCtwQkRhTkdYbVVa?=
 =?gb2312?B?alFNNUpaM3lRMWZvL1E5dWJOS256cWJBSU00UHZmYnhLckV4SUJVL1NSZkJ4?=
 =?gb2312?B?TTE0TEQ4bnpLUWk4YTZKZHpraUxKYnpnamtrUXZjNHJyaEZIdjZEU3FwbU5F?=
 =?gb2312?B?V2Y1a0loM1A3aUF6RUpvcmZwTkE1SklXTkU1RkxpQm5Oc0dPaWEyTm1xcHJo?=
 =?gb2312?B?c2Q5ZXVQQlpielc3N0pBdDlNUTBCdGFkaHRrdXlQY0tiSUhCZXpOcWs4S1dp?=
 =?gb2312?B?Zk16VGdJVkEwbnhQZzNnSWl6YmJ2M2I2a2l6VnJheVRudEZEU1g4WElQWnRK?=
 =?gb2312?B?QzlDQUJxKzF3Z0c5VkZxZ3VQbjhBQXQxQTlCVnFWSEZOYUdHRUttZFdlU0Vt?=
 =?gb2312?B?VmduWTdlR1N0THFFRHJyL2d5aVl5NTdqbWF0T09rbXJnS0xNaE82MmtTQ1JQ?=
 =?gb2312?B?TENCeDVKa3ZpR3BtQjJFRnk0eHIyblMyN090cGVCb0hmZkJ1blYzK0pxYnNE?=
 =?gb2312?B?Zm5pZDZEZDF1aFFhWDU5TXl2Ykh3NHBYS0xtb09uQS92bVoycXU5UGttMWhB?=
 =?gb2312?B?a0ZJd0pmSnZaMFNnR2JXNzVZZFVZSHN6amJOZ3BIWUFOZFNZMnJoR1VZd2xQ?=
 =?gb2312?B?TFppWSswdTNrZGdvdWJhV3NrRllxd0QvTWNHcHVqTmxoUHVwL1cyYVZoTnh1?=
 =?gb2312?B?QmpmMTkxaDlROVd0QTk3Rmw1UThBUUFGNXFpTDQ1aXVBM1l1THgyM0RyTHN4?=
 =?gb2312?Q?/gGx6Hvp5u+o51Wc0uKC2/khK?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59970E86C206C20D162DE293823F9PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ee45f5-d309-4f51-4c7e-08dac12a5f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 01:41:36.2194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1UgUiNztUxcWyUXXof3HFXNkiXdVf5PyuPVllww5gn9+uf17RLRQMtYAm02ZPas
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB59970E86C206C20D162DE293823F9PH7PR12MB5997namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCmEgdHlwbyBpc3N1ZSBpbiBjb21t
aXQgbWVzc2FnZTogICJtc3UiLA0KYW5kIG9uZSBjb21tZW50IGlubGluZS4NCg0KUmV2aWV3ZWQt
Ynk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVzdCBSZWdhcmRzDQpL
ZXZpbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogYW1kLWdmeCA8
YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gtPqx7SBLZW5uZXRoIEZlbmcg
PGtlbm5ldGguZmVuZ0BhbWQuY29tPg0Kt6LLzcqxvOQ6IDIwMjLE6jEx1MI4yNXQx8batv4gyc/O
5zg6MzYNCsrVvP7IyzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCrOty806IEZlbmcs
IEtlbm5ldGgNCtb3zOI6IFtQQVRDSCB2Ml0gZHJtL2FtZC9wbTogZW5hYmxlIG1vZGUxIHJlc2V0
IG9uIHNtdV92MTNfMF8xMA0KDQplbmFibGUgbW9kZTEgcmVzZXQgYW5kIHByaW9yaXRpemUgZGVi
dWcgcG9ydCBvbiBtc3VfdjEzXzBfMTANCmFzIGEgbW9yZSByZWxpYWJsZSBtZXNzYWdlIHByb2Nl
c3NpbmcNCg0KdjIgLSBtb3ZlIG1vZGUxIHJlc2V0IGNhbGxiYWNrIHRvIHNtdV92MTNfMF8wX3Bw
dC5jDQoNClNpZ25lZC1vZmYtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jICAgICAgICAgICAgfCAg
MSArDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oIHwgIDQg
KysNCiAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYyAgfCA1MyAr
KysrKysrKysrKysrKysrKystDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21u
LmMgICAgICAgIHwgMTggKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
X2Ntbi5oICAgICAgICB8ICAzICsrDQogNSBmaWxlcyBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCmluZGV4IDFk
NDAxM2VkMGQxMC4uYjI1OGU5YWEwNTU4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMjEuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEu
Yw0KQEAgLTMyMiw2ICszMjIsNyBAQCBzb2MyMV9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikNCiAgICAgICAgIHN3aXRjaCAoYWRldi0+aXBfdmVyc2lvbnNbTVAx
X0hXSVBdWzBdKSB7DQogICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDApOg0KICAgICAg
ICAgY2FzZSBJUF9WRVJTSU9OKDEzLCAwLCA3KToNCisgICAgICAgY2FzZSBJUF9WRVJTSU9OKDEz
LCAwLCAxMCk6DQogICAgICAgICAgICAgICAgIHJldHVybiBBTURfUkVTRVRfTUVUSE9EX01PREUx
Ow0KICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDEzLCAwLCA0KToNCiAgICAgICAgICAgICAgICAg
cmV0dXJuIEFNRF9SRVNFVF9NRVRIT0RfTU9ERTI7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oDQppbmRleCBlMmZhM2IwNjZiOTYuLjFiYzI2ZTkzYTgz
YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdwdV9z
bXUuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5o
DQpAQCAtNTY4LDYgKzU2OCwxMCBAQCBzdHJ1Y3Qgc211X2NvbnRleHQNCiAgICAgICAgIHUzMiBw
YXJhbV9yZWc7DQogICAgICAgICB1MzIgbXNnX3JlZzsNCiAgICAgICAgIHUzMiByZXNwX3JlZzsN
CisNCisgICAgICAgdTMyIGRlYnVnX3BhcmFtX3JlZzsNCisgICAgICAgdTMyIGRlYnVnX21zZ19y
ZWc7DQorICAgICAgIHUzMiBkZWJ1Z19yZXNwX3JlZzsNCiB9Ow0KDQogc3RydWN0IGkyY19hZGFw
dGVyOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211
X3YxM18wXzBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92
MTNfMF8wX3BwdC5jDQppbmRleCAyOTUyOTMyODE1MmQuLjU4ODUyNzMxMDE4OCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0LmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0
LmMNCkBAIC03MCw2ICs3MCwyNiBAQA0KDQogI2RlZmluZSBNUDBfTVAxX0RBVEFfUkVHSU9OX1NJ
WkVfQ09NQk9QUFRBQkxFICAgMHg0MDAwDQoNCisjZGVmaW5lIG1tTVAxX1NNTl9DMlBNU0dfNjYg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgMHgwMjgyDQorI2RlZmluZSBtbU1QMV9TTU5fQzJQTVNHXzY2X0JB
U0VfSURYICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDANCisNCisjZGVmaW5lIG1tTVAxX1NNTl9DMlBNU0dfODIgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMHgwMjkyDQorI2RlZmluZSBtbU1QMV9TTU5fQzJQTVNHXzgyX0JBU0VfSURY
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDANCisNCisjZGVmaW5lIG1tTVAxX1NNTl9DMlBNU0dfOTAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMHgwMjlhDQorI2RlZmluZSBtbU1QMV9TTU5fQzJQTVNHXzkwX0JBU0VfSURYICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDANCisNCisjZGVmaW5lIG1tTVAxX1NNTl9DMlBNU0dfNzUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MHgwMjhiDQorI2RlZmluZSBtbU1QMV9TTU5fQzJQTVNHXzc1X0JBU0VfSURYICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAN
CisNCisjZGVmaW5lIG1tTVAxX1NNTl9DMlBNU0dfNTMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMjc1
DQorI2RlZmluZSBtbU1QMV9TTU5fQzJQTVNHXzUzX0JBU0VfSURYICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDANCisNCisj
ZGVmaW5lIG1tTVAxX1NNTl9DMlBNU0dfNTQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMjc2DQorI2Rl
ZmluZSBtbU1QMV9TTU5fQzJQTVNHXzU0X0JBU0VfSURYICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDANCisNCisjZGVmaW5l
IERFQlVHU01DX01TR19Nb2RlMVJlc2V0ICAgICAgICAyDQorDQogc3RhdGljIHN0cnVjdCBjbW4y
YXNpY19tc2dfbWFwcGluZyBzbXVfdjEzXzBfMF9tZXNzYWdlX21hcFtTTVVfTVNHX01BWF9DT1VO
VF0gPSB7DQogICAgICAgICBNU0dfTUFQKFRlc3RNZXNzYWdlLCAgICAgICAgICAgICAgICAgICAg
UFBTTUNfTVNHX1Rlc3RNZXNzYWdlLCAgICAgICAgICAgICAgICAgMSksDQogICAgICAgICBNU0df
TUFQKEdldFNtdVZlcnNpb24sICAgICAgICAgICAgICAgICAgUFBTTUNfTVNHX0dldFNtdVZlcnNp
b24sICAgICAgICAgICAgICAgMSksDQpAQCAtMTc2Myw2ICsxNzgzLDM1IEBAIHN0YXRpYyBpbnQg
c211X3YxM18wXzBfc2V0X2RmX2NzdGF0ZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOw0KIH0NCg0K
K3N0YXRpYyBpbnQgc211X3YxM18wXzBfbW9kZTFfcmVzZXQoc3RydWN0IHNtdV9jb250ZXh0ICpz
bXUpDQorew0KKyAgICAgICBpbnQgcmV0ID0gMDsNCmtldmluOg0KTm8gaW5pdGlhbGl6YXRpb24g
cmVxdWlyZWQNCg0KKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHNtdS0+YWRl
djsNCisNCisgICAgICAgaWYgKGFkZXYtPmlwX3ZlcnNpb25zW01QMV9IV0lQXVswXSA9PSBJUF9W
RVJTSU9OKDEzLCAwLCAxMCkpDQorICAgICAgICAgICAgICAgcmV0ID0gc211X2Ntbl9zZW5kX2Rl
YnVnX3NtY19tc2coc211LCBERUJVR1NNQ19NU0dfTW9kZTFSZXNldCk7DQorICAgICAgIGVsc2UN
CisgICAgICAgICAgICAgICByZXQgPSBzbXVfY21uX3NlbmRfc21jX21zZyhzbXUsIFNNVV9NU0df
TW9kZTFSZXNldCwgTlVMTCk7DQorDQorICAgICAgIGlmICghcmV0KQ0KKyAgICAgICAgICAgICAg
IG1zbGVlcChTTVUxM19NT0RFMV9SRVNFVF9XQUlUX1RJTUVfSU5fTVMpOw0KKw0KKyAgICAgICBy
ZXR1cm4gcmV0Ow0KK30NCisNCitzdGF0aWMgdm9pZCBzbXVfdjEzXzBfMF9zZXRfc211X21haWxi
b3hfcmVnaXN0ZXJzKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KK3sNCisgICAgICAgc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFkZXY7DQorDQorICAgICAgIHNtdS0+cGFyYW1f
cmVnID0gU09DMTVfUkVHX09GRlNFVChNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfODIpOw0KKyAg
ICAgICBzbXUtPm1zZ19yZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKE1QMSwgMCwgbW1NUDFfU01OX0My
UE1TR182Nik7DQorICAgICAgIHNtdS0+cmVzcF9yZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKE1QMSwg
MCwgbW1NUDFfU01OX0MyUE1TR185MCk7DQorDQorICAgICAgIHNtdS0+ZGVidWdfcGFyYW1fcmVn
ID0gU09DMTVfUkVHX09GRlNFVChNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfNTMpOw0KKyAgICAg
ICBzbXUtPmRlYnVnX21zZ19yZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKE1QMSwgMCwgbW1NUDFfU01O
X0MyUE1TR183NSk7DQorICAgICAgIHNtdS0+ZGVidWdfcmVzcF9yZWcgPSBTT0MxNV9SRUdfT0ZG
U0VUKE1QMSwgMCwgbW1NUDFfU01OX0MyUE1TR181NCk7DQorfQ0KKw0KIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgcHB0YWJsZV9mdW5jcyBzbXVfdjEzXzBfMF9wcHRfZnVuY3MgPSB7DQogICAgICAgICAu
Z2V0X2FsbG93ZWRfZmVhdHVyZV9tYXNrID0gc211X3YxM18wXzBfZ2V0X2FsbG93ZWRfZmVhdHVy
ZV9tYXNrLA0KICAgICAgICAgLnNldF9kZWZhdWx0X2RwbV90YWJsZSA9IHNtdV92MTNfMF8wX3Nl
dF9kZWZhdWx0X2RwbV90YWJsZSwNCkBAIC0xODMwLDcgKzE4NzksNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHBwdGFibGVfZnVuY3Mgc211X3YxM18wXzBfcHB0X2Z1bmNzID0gew0KICAgICAgICAg
LmJhY29fZW50ZXIgPSBzbXVfdjEzXzBfYmFjb19lbnRlciwNCiAgICAgICAgIC5iYWNvX2V4aXQg
PSBzbXVfdjEzXzBfYmFjb19leGl0LA0KICAgICAgICAgLm1vZGUxX3Jlc2V0X2lzX3N1cHBvcnQg
PSBzbXVfdjEzXzBfMF9pc19tb2RlMV9yZXNldF9zdXBwb3J0ZWQsDQotICAgICAgIC5tb2RlMV9y
ZXNldCA9IHNtdV92MTNfMF9tb2RlMV9yZXNldCwNCisgICAgICAgLm1vZGUxX3Jlc2V0ID0gc211
X3YxM18wXzBfbW9kZTFfcmVzZXQsDQogICAgICAgICAuc2V0X21wMV9zdGF0ZSA9IHNtdV92MTNf
MF8wX3NldF9tcDFfc3RhdGUsDQogICAgICAgICAuc2V0X2RmX2NzdGF0ZSA9IHNtdV92MTNfMF8w
X3NldF9kZl9jc3RhdGUsDQogfTsNCkBAIC0xODQ0LDUgKzE4OTMsNSBAQCB2b2lkIHNtdV92MTNf
MF8wX3NldF9wcHRfZnVuY3Moc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQogICAgICAgICBzbXUt
PnRhYmxlX21hcCA9IHNtdV92MTNfMF8wX3RhYmxlX21hcDsNCiAgICAgICAgIHNtdS0+cHdyX3Ny
Y19tYXAgPSBzbXVfdjEzXzBfMF9wd3Jfc3JjX21hcDsNCiAgICAgICAgIHNtdS0+d29ya2xvYWRf
bWFwID0gc211X3YxM18wXzBfd29ya2xvYWRfbWFwOw0KLSAgICAgICBzbXVfdjEzXzBfc2V0X3Nt
dV9tYWlsYm94X3JlZ2lzdGVycyhzbXUpOw0KKyAgICAgICBzbXVfdjEzXzBfMF9zZXRfc211X21h
aWxib3hfcmVnaXN0ZXJzKHNtdSk7DQogfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211X2Ntbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVf
Y21uLmMNCmluZGV4IGU0ZjhmOTBhYzVhYS4uNzY4YjZlN2RiZDc3IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQpAQCAtMjMzLDYgKzIzMywxOCBAQCBzdGF0aWMgdm9p
ZCBfX3NtdV9jbW5fc2VuZF9tc2coc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQogICAgICAgICBX
UkVHMzIoc211LT5tc2dfcmVnLCBtc2cpOw0KIH0NCg0KK3N0YXRpYyBpbnQgX19zbXVfY21uX3Nl
bmRfZGVidWdfbXNnKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHUzMiBtc2csDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMy
IHBhcmFtKQ0KK3sNCisgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFk
ZXY7DQorDQorICAgICAgIFdSRUczMihzbXUtPmRlYnVnX3BhcmFtX3JlZywgcGFyYW0pOw0KKyAg
ICAgICBXUkVHMzIoc211LT5kZWJ1Z19tc2dfcmVnLCBtc2cpOw0KKyAgICAgICBXUkVHMzIoc211
LT5kZWJ1Z19yZXNwX3JlZywgMCk7DQorDQorICAgICAgIHJldHVybiAwOw0KK30NCiAvKioNCiAg
KiBzbXVfY21uX3NlbmRfbXNnX3dpdGhvdXRfd2FpdGluZyAtLSBzZW5kIHRoZSBtZXNzYWdlOyBk
b24ndCB3YWl0IGZvciBzdGF0dXMNCiAgKiBAc211OiBwb2ludGVyIHRvIGFuIFNNVSBjb250ZXh0
DQpAQCAtMzg2LDYgKzM5OCwxMiBAQCBpbnQgc211X2Ntbl9zZW5kX3NtY19tc2coc3RydWN0IHNt
dV9jb250ZXh0ICpzbXUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZWFkX2FyZyk7DQogfQ0KDQoraW50IHNtdV9jbW5fc2VuZF9kZWJ1Z19zbWNfbXNn
KHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQz
Ml90IG1zZykNCit7DQorICAgICAgIHJldHVybiBfX3NtdV9jbW5fc2VuZF9kZWJ1Z19tc2coc211
LCBtc2csIDApOw0KK30NCisNCiBpbnQgc211X2Ntbl90b19hc2ljX3NwZWNpZmljX2luZGV4KHN0
cnVjdCBzbXVfY29udGV4dCAqc211LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZW51bSBzbXVfY21uMmFzaWNfbWFwcGluZ190eXBlIHR5cGUsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBpbmRleCkNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5oDQppbmRleCAxNTI2Y2UwOWMzOTkuLmY4MmNmNzZkZDNhNCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5oDQorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uaA0KQEAgLTQyLDYgKzQyLDkgQEAgaW50
IHNtdV9jbW5fc2VuZF9zbWNfbXNnKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICBlbnVtIHNtdV9tZXNzYWdlX3R5cGUgbXNnLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCAqcmVhZF9hcmcpOw0KDQoraW50IHNtdV9jbW5fc2VuZF9k
ZWJ1Z19zbWNfbXNnKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IG1zZyk7DQorDQogaW50IHNtdV9jbW5fd2FpdF9mb3JfcmVzcG9uc2Uo
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KDQogaW50IHNtdV9jbW5fdG9fYXNpY19zcGVjaWZp
Y19pbmRleChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCi0tDQoyLjI1LjENCg0KDQo=

--_000_PH7PR12MB59970E86C206C20D162DE293823F9PH7PR12MB5997namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"color: rgb(33, 33, 33); background-color: rgb(25=
5, 255, 255);">
<div dir=3D"auto" style=3D"color:rgb(0, 0, 0);font-size:14.6667px;backgroun=
d-color:rgb(255, 255, 255)">
a typo issue in commit message:&nbsp; &quot;msu&quot;,<br>
</div>
<div dir=3D"auto" style=3D"color:rgb(0, 0, 0);font-size:14.6667px;backgroun=
d-color:rgb(255, 255, 255)">
and one comment inline.<br>
</div>
<div dir=3D"auto" style=3D"color:rgb(0, 0, 0);font-size:14.6667px;backgroun=
d-color:rgb(255, 255, 255)">
<br>
</div>
<div dir=3D"auto" style=3D"color:rgb(0, 0, 0);font-size:14.6667px;backgroun=
d-color:rgb(255, 255, 255)">
<div dir=3D"auto" style=3D"background-color:rgb(255, 255, 255)">Reviewed-by=
: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div dir=3D"auto" style=3D"background-color:rgb(255, 255, 255)"><br>
</div>
<div dir=3D"auto" style=3D"background-color:rgb(255, 255, 255)">Best Regard=
s</div>
<div dir=3D"auto" style=3D"background-color:rgb(255, 255, 255)">Kevin</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto" id=3D"mail-editor-reference-message-container">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg"><strong>=B7=A2=BC=FE=C8=CB:</strong> amd-gfx &lt;=
amd-gfx-bounces@lists.freedesktop.org&gt; =B4=FA=B1=ED Kenneth Feng &lt;ken=
neth.feng@amd.com&gt;<br>
<strong>=B7=A2=CB=CD=CA=B1=BC=E4:</strong> 2022=C4=EA11=D4=C28=C8=D5=D0=C7=
=C6=DA=B6=FE =C9=CF=CE=E78:36<br>
<strong>=CA=D5=BC=FE=C8=CB:</strong> amd-gfx@lists.freedesktop.org<br>
<strong>=B3=AD=CB=CD:</strong> Feng, Kenneth<br>
<strong>=D6=F7=CC=E2:</strong> [PATCH v2] drm/amd/pm: enable mode1 reset on=
 smu_v13_0_10<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText" dir=3D"auto">enable mode1 reset and prioritize deb=
ug port on msu_v13_0_10<br>
as a more reliable message processing<br>
<br>
v2 - move mode1 reset callback to smu_v13_0_0_ppt.c<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp; 4 ++<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp; | 53 +++++++++++++=
+++++-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 18 +++++++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 3 ++<br>
&nbsp;5 files changed, 77 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index 1d4013ed0d10..b258e9aa0558 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -322,6 +322,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[MP1_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 7):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 10):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_MODE1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 4):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_MODE2;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index e2fa3b066b96..1bc26e93a83c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -568,6 +568,10 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 param_reg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 msg_reg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 resp_reg;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 debug_param_reg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 debug_msg_reg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 debug_resp_reg;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct i2c_adapter;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 29529328152d..588527310188 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -70,6 +70,26 @@<br>
&nbsp;<br>
&nbsp;#define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE&nbsp;&nbsp; 0x4000<br>
&nbsp;<br>
+#define mmMP1_SMN_C2PMSG_66&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0282<br>
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_82&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0292<br>
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x029a<br>
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_75&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x028b<br>
+#define mmMP1_SMN_C2PMSG_75_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_53&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0275<br>
+#define mmMP1_SMN_C2PMSG_53_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_54&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0276<br>
+#define mmMP1_SMN_C2PMSG_54_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define DEBUGSMC_MSG_Mode1Reset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2<br>
+<br>
&nbsp;static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MA=
X_COUNT] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TestMessage,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TestMessage,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSmuVersion,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetSmuVersion,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
@@ -1763,6 +1783,35 @@ static int smu_v13_0_0_set_df_cstate(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
&nbsp;}<br>
&nbsp;<br>
+static int smu_v13_0_0_mode1_reset(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</div>
<div class=3D"PlainText" dir=3D"auto">kevin:</div>
<div class=3D"PlainText" dir=3D"auto"><span style=3D"font-size: 11pt;">No i=
nitialization required</span><br>
</div>
<div class=3D"PlainText" dir=3D"auto"><br>
</div>
<div class=3D"PlainText" dir=3D"auto">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct amdgpu_device *adev =3D smu-&gt;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 10))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)=
<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;param_reg =3D SOC15_REG_OFFSE=
T(MP1, 0, mmMP1_SMN_C2PMSG_82);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;msg_reg =3D SOC15_REG_OFFSET(=
MP1, 0, mmMP1_SMN_C2PMSG_66);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;resp_reg =3D SOC15_REG_OFFSET=
(MP1, 0, mmMP1_SMN_C2PMSG_90);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;debug_param_reg =3D SOC15_REG=
_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;debug_msg_reg =3D SOC15_REG_O=
FFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;debug_resp_reg =3D SOC15_REG_=
OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);<br>
+}<br>
+<br>
&nbsp;static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_allowed_feature_mask =
=3D smu_v13_0_0_get_allowed_feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D=
 smu_v13_0_0_set_default_dpm_table,<br>
@@ -1830,7 +1879,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v13_0_=
baco_enter,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_b=
aco_exit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset_is_support =
=3D smu_v13_0_0_is_mode1_reset_supported,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D smu_v13_0_mode1_rese=
t,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D smu_v13_0_0_mode1_re=
set,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D smu_v13=
_0_0_set_mp1_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_df_cstate =3D smu_v13=
_0_0_set_df_cstate,<br>
&nbsp;};<br>
@@ -1844,5 +1893,5 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D smu_=
v13_0_0_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pwr_src_map =3D sm=
u_v13_0_0_pwr_src_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_map =3D s=
mu_v13_0_0_workload_map;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_set_smu_mailbox_registers(s=
mu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_0_set_smu_mailbox_registers=
(smu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index e4f8f90ac5aa..768b6e7dbd77 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -233,6 +233,18 @@ static void __smu_cmn_send_msg(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(smu-&gt;msg_reg, ms=
g);<br>
&nbsp;}<br>
&nbsp;<br>
+static int __smu_cmn_send_debug_msg(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u32 msg,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u32 param)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(smu-&gt;debug_param_reg, param=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(smu-&gt;debug_msg_reg, msg);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(smu-&gt;debug_resp_reg, 0);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
&nbsp;/**<br>
&nbsp; * smu_cmn_send_msg_without_waiting -- send the message; don't wait f=
or status<br>
&nbsp; * @smu: pointer to an SMU context<br>
@@ -386,6 +398,12 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_arg);<br>
&nbsp;}<br>
&nbsp;<br>
+int smu_cmn_send_debug_smc_msg(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t m=
sg)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return __smu_cmn_send_debug_msg(smu, =
msg, 0);<br>
+}<br>
+<br>
&nbsp;int smu_cmn_to_asic_specific_index(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_cmn2a=
sic_mapping_type type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index=
)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h<br>
index 1526ce09c399..f82cf76dd3a4 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
@@ -42,6 +42,9 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 enum smu_message_type msg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 uint32_t *read_arg);<br>
&nbsp;<br>
+int smu_cmn_send_debug_smc_msg(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t m=
sg);<br>
+<br>
&nbsp;int smu_cmn_wait_for_response(struct smu_context *smu);<br>
&nbsp;<br>
&nbsp;int smu_cmn_to_asic_specific_index(struct smu_context *smu,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font><br>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB59970E86C206C20D162DE293823F9PH7PR12MB5997namp_--
