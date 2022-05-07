Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A454C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  7 May 2022 01:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C532D10E916;
	Sat,  7 May 2022 01:35:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F5E10E916
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 May 2022 01:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPBw56TardC/uvhIDYAMqPSCn8Ftl131BE8UDPZlg6RBpPYutY6UIbkM7bd7Cun51jyV8sI05dBeWKomPfSvMzWlQekja4AueEyyCa7u8fSwJucplca0Q++VEF+Akos5rs3xJ6zcmIxTEDGtyJ2JEiVh8OSjnrHdOXume8t99dvXx0ExA2mO2BdMXdkvK8PyURmaUxVGPD9iPHygbZ7NKxeHq7ZecSzBkfIQWmRS1M6kATnpnsW3AVoolj1x7KxqLY2HTFapjXyNEP+2Lz0To/nCp3ODy9ku99KifgPidTjyni5kv1zTdBsKo2AxjZnZBynQYIsN/HBwIsHB2TE0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAGdSBB0Bn7BPU1l1sbGzNcW2+q6k5xfaMMUYJAYFuQ=;
 b=hYfun1AqLa/9CAd3ajZ7BIm6rnNuSyKgiVJq2P0ihf0hm1TPhy0EOxJvoA1Z36jUIBi3RIWCSzzWtq1rfE02LBrn/I6fzOC8SchWd83XmJoAMIy73hQV7/ZAEnW2sGx5XOcWfNbK+dS5tMW2HP+vLfC7x2/svsFgVdQTVg26kqn9urCFNbcUTRBl9j6sIY3lpnzU2HWLTElKT4nUYyth+k5jJcS5IE1T48yV02fu1iJkAfJLO3XOo2OkjAk4ce6YcDqJKJPeXhLgbdhHJ7jtKSCNSoKG44BPn9ocydHek41SLoVEd8QwnAJOUpBwui+GjjiS7a6H3dBQiIXRL9kfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAGdSBB0Bn7BPU1l1sbGzNcW2+q6k5xfaMMUYJAYFuQ=;
 b=YPi38A23NF720Qb3PyYQpXVmOhdZQmKtq8Kv5261jXWq/TlNxWFU2vsEwonK9H2GBEArP185r7pRg96ZxRJYGDXqmc2GC6VEv8Ge2KqHFnvPdn5m+HX8u11Rz/aIci22dYzSZT0wAyUCep7j9pFj2VZEYiDNc8zW0SMk8XjPj5A=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Sat, 7 May
 2022 01:35:14 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad%4]) with mapi id 15.20.5206.025; Sat, 7 May 2022
 01:35:14 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vYW1kZ3B1OiB1c2UgcHJvcGVyIGluZGV4IGlu?=
 =?gb2312?B?IHNtdV92MTNfMF83X2dldF9wb3dlcl9wcm9maWxlX21vZGUoKQ==?=
Thread-Topic: [PATCH] drm/amdgpu: use proper index in
 smu_v13_0_7_get_power_profile_mode()
Thread-Index: AQHYYVKR5CT4eICRVkete6VlBAGFqK0SoniV
Date: Sat, 7 May 2022 01:35:14 +0000
Message-ID: <DM4PR12MB5165C69F5EA65AC2ED8A49638EC49@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220506140652.2448793-1-alexander.deucher@amd.com>
In-Reply-To: <20220506140652.2448793-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-07T01:34:13.5812992Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c84c2865-8776-4441-15f7-08da2fc9d5a6
x-ms-traffictypediagnostic: MN0PR12MB6125:EE_
x-microsoft-antispam-prvs: <MN0PR12MB6125CE30AB691DF77F43B2C58EC49@MN0PR12MB6125.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSrOQktuVP4waWUyf4o97qV1qSPPzXBqANh1jvqLRUIQx4JcKyY1fbL01idxyrNWY8wXSfzAmV1xOC4AdcKmj8J97dNGFeuAPRoXX54Siuxn/j5MapW3stX4nYca7FyFJUViOSuTbIqEUljuT4MkkR/LxBolb8TzmqKPNQ/ygmGO7gqj72i0ccDMfgd6vyblJsolDTLccHh0XAkxDG6VgJZBRn4DQmVtv4EOhnMEovmzv5Vw6Ve4tHMvC88zzGDxCxhd6WlqGhnuS39YD94CoLW0Jkb0QZsfpLvT38yRBywmCDHNMNfhX02ZygW6TLFLoJNhjYGhLhzFpMOaJ4wiAU4xtcNiwF4tvRz6mYFPAZq0sAMByXWsuPXcww+haYR5PPTZ3PTJ4APLdj5EtYQuE/A7pGQExuPVCYxGYvzhizyGJINaXUoytcO51Pe1xVb3Al/iwVtlK+WdTSFbtd4WfYPLpgBsPUPUizsapWgU4TyKHCA1wEqFWO6eEXUUPvOYWLsIpv0gMY/uswli9g8Ug8c2eJQ9oY7m+iBDsq7P/zuq9O3oL+9ZWsUrlSm2zMMETk/bfmE8zXRgTGq+4r52thnIjrIaIaR6cSW7xnxTj98nNyfmRgRVJduyjphaDL0uB8mEwtRdPuWbhw4hPyWOSL3ecWS37P8ZtmtwpHhgBX/T1Y9Mm+/15nOh06jkwlyipE/zP5QLO7374vnuQSjuAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(5660300002)(508600001)(83380400001)(2906002)(110136005)(8936002)(66446008)(66476007)(71200400001)(64756008)(52536014)(316002)(4326008)(66946007)(91956017)(224303003)(66556008)(76116006)(9686003)(33656002)(186003)(7696005)(6506007)(38070700005)(38100700002)(86362001)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?enA1b3gzNVprZEhIY2hWR09oYm9HYTBxS3pVUzE3eS9JZ1BIT2M0TitkYVdT?=
 =?gb2312?B?dWh2ajAxQUJiRGJDUnlaejN6VkdXZ1M1WWllUm5GcHVYVmhhdVNISmhOTTJa?=
 =?gb2312?B?OERLdVBEQmZRcGZIbERhM3VGam55cGFCdk95SHI0UU9tZU5EWEZWK0g2dmcz?=
 =?gb2312?B?SDIwd3pnSDFtRmpQczlFaDArRFRQRnUvU1JjTitpaHJ1bkxxNXZTRzdNREZo?=
 =?gb2312?B?aXliUTJ4cERzazAzK0poUkdzS3BMT0VvSlpSbHI1bU5uQVNyOGp3dElyQThx?=
 =?gb2312?B?UTBBbis4T014ZytaSXZKWDdmVlZsT2o2TUtHMFZYa3hLd20waHU0eGRKYTY0?=
 =?gb2312?B?VWU3ekNhQVVxZVlCeVduenl0NTJ2VWRrSVRrNmUvUzlJQ3VLeXYrS0tMTXVF?=
 =?gb2312?B?N3BXZ1lWNGFDMWh6Sk9OdmdvZnpqOGllWkhPM3JWYTRIQlFRUmN1NEszc2t6?=
 =?gb2312?B?WnBKU3lzY3FRdTIxNXlvaE5rbjhwblh6NGRCVzc1eTJrMm9hMVQxZ0drYm9Q?=
 =?gb2312?B?U2t0V2pGbGtQdUs5UlpTU3lIOEJsdmVNRUJGQkluYnlCVm5NbVZGbnZjbXpn?=
 =?gb2312?B?T1NSYmgvRTgrMTUvclZ6d3JhT3kxZXNtbTU2STNWTHpZMW1qdkkvNnducERX?=
 =?gb2312?B?YmVzUTd3YnBtNTB1MDhzbk85c2JrbnpQR2taZDFxS2U1ZHRKNUZMMWc5N1U2?=
 =?gb2312?B?dlZxcXRUTTBMWHhGa2g4WFE5dlNlN2MxNnVGbWhDeXEwNzBoZnZoajlSeGRP?=
 =?gb2312?B?ZU5VeU93TkpCMklwZXQ5SjNETnY1TTFlQlJxRlo4ZVlzclNkbitrVFBGVjVj?=
 =?gb2312?B?VThRbXBnZVdXNytmSEp4VGk4WHpkZ1hqaG9JcGdOdlcya1V1dWtjbjdsakhv?=
 =?gb2312?B?ZGEwZVgxTHVPdG5lcks0bTdtbEZXZDZPOHd3dW5lQm44NmJlenZUTjBLZmc0?=
 =?gb2312?B?OC9SSUJlaDVBQlNRc25kRElHcDc3NHEzQVZ4aDM0WEc0ZkxtUitwUmhsK3Jy?=
 =?gb2312?B?ZWlET2JpZ2Z3TWF5dWI3bmo0dk9sbHdhMzh3TTREVjFIOEVjQklSUDNYUU5s?=
 =?gb2312?B?UnQ2QlcvbWtFZnhhL3M5bWJvTUxRMHpmTzMwb0ZtTFNyWFVQM1N5YTBtelJZ?=
 =?gb2312?B?alAxeHFzUmx1TEZDTHg0cW5Oa0dFSzJjUldVLzdORW1SUlU5N2xWY0VvaXNo?=
 =?gb2312?B?aDNWNVVXNXZJd0thaURWdUJqNWZIa0cyUlE1NGNNNGdrZG11RmxyOFZIeVhr?=
 =?gb2312?B?Nm9OdmVvcTN4WVBMRnhrVXY2dVNsWEJtc0MwZ1FXQ3BnM0ZORWJXYTlrQkVX?=
 =?gb2312?B?cWN1bTJkK2NYZTQwdGszZExWRXhWbEVXSEVCNTduNUNuK0tBOERFTG4yRWdh?=
 =?gb2312?B?c1BtaGRuSU4zaUFaT3dKZWliY09UVytVTldPc3ljVWgxYk05OStMUG9YU3B0?=
 =?gb2312?B?K2JvT3Q5dHZBelNNV0Z3dGU4Ymh1U1ZEczQ4UjFhdXRJamNsQ0l3LzQwTGlv?=
 =?gb2312?B?QnJ1VXhpenlkd3pqYjd1cWtCaGc0azBiNXFjRjVndGpEL09nUHZHQ0ZEWlRt?=
 =?gb2312?B?dEJzMS9IZU4zUXNxazhLM3F0S1pqTDJicVQrQ0NvRnh5YXViSmZYK3dUV2Jw?=
 =?gb2312?B?cUlQQ29JRVdCeGtIeHlIYVhPUWkrcnl4akdGSXh3bW9RdENieFJRZXZDQldF?=
 =?gb2312?B?alBvYzVUcHB6RW82MVBXNFV4Q3VTQXZKMEdzMmJVemszc1VNRWUxNzMwY1pw?=
 =?gb2312?B?TEFNZFpBRk5vTTZ3bkp3aFJCZHRmeEtXN0FOUkM4eS9CeVB6Z1BkTzQ2bVNH?=
 =?gb2312?B?clQ2Mk16WFlVNWJXWlNBa1hMWEFmZy90WlgrSUUvY2VTalNBMUE2UUlidzB6?=
 =?gb2312?B?NGJneDhsM0JOalVkR0RIdEw0NndJbFB2eG9BTkMyNjB5MUtxVnlhVUVVLzY3?=
 =?gb2312?B?UGRQNmZrQXJocmU2WU1JVTRIK2lFOEoyWUFhVVZjL3UwaGtIVDBnM1BXY0NM?=
 =?gb2312?B?T2IvYzBWN2VIZU1lNjVzY0ZaVjliT1FZYzZHUHRFbDZIbUVEWndUTnZNYVNC?=
 =?gb2312?B?R1Z4bi9YQlRZUENoajVsNlN6eGFEZmVhampPRW9FYWJxQnAwWGNHYXA1dkFu?=
 =?gb2312?B?cEtRK0N0djU4WnFZNkpLS1loMm5IZzJCZDJPbFUzbkFFTjk0L21vLytyWEEx?=
 =?gb2312?B?U0QyLytaZGtaL1dhYXBlTU5hbXUxa3Q5b2srbjcvYjZPYVc3RUpqaENzR3ZK?=
 =?gb2312?B?dmZzdHhIVVJsSWZKWmd0TmRCOHhqSHNTWWtZdVNGT3Z0UzJVUjQ3dXg3UVdB?=
 =?gb2312?B?R1FwM2pKN21jUGszRGNIK0wxY3lwZG0yaGxrNVA3dTJrMlowRVdjaXNnMFQw?=
 =?gb2312?Q?JT66TS4aM1/wYCbfjWxfJfo4bkaqFuMwc1kqmU0v2jVw2?=
x-ms-exchange-antispam-messagedata-1: 4Y5r/vZBpWHtlA==
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5165C69F5EA65AC2ED8A49638EC49DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84c2865-8776-4441-15f7-08da2fc9d5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 01:35:14.5398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6uGo129M5evsVnPy0NyMEAhD9JJJFd+7dta3smOPfzCJzoCNv22XVwPZa/zbhmK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5165C69F5EA65AC2ED8A49638EC49DM4PR12MB5165namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBLZW5uZXRo
IEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPG1haWx0bzprZW5uZXRoLmZlbmdAYW1kLmNvbT4+
DQoNCkJlc3Qgd2lzaGVzDQpLZW5uZXRoIEZlbmcNCg0KDQq3orz+yMs6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCsjVxto6INDHxtrO5SwgMjAyMsTqNdTC
NsjVIDIyOjA3DQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCrOty806IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT4sIEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29t
PiwgU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQrW98ziOiBbUEFUQ0hd
IGRybS9hbWRncHU6IHVzZSBwcm9wZXIgaW5kZXggaW4gc211X3YxM18wXzdfZ2V0X3Bvd2VyX3By
b2ZpbGVfbW9kZSgpDQpPdGhlcndpc2Ugd2UgZ2V0IGFuIG91dCBvZiBib3VuZHMgYWNjZXNzLg0K
DQpGaXhlczogODc4MjA1YjhjMTcwICgiZHJtL2FtZC9wbTogZW5hYmxlIHdvcmtsb2FkIHR5cGUg
Y2hhbmdlIG9uIHNtdV92MTNfMF83IikNClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCkNjOiBLZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0Bh
bWQuY29tPg0KQ2M6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcub3JnLmF1Pg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyB8
IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18w
XzdfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83
X3BwdC5jDQppbmRleCA4ZTU3NjA1NGJlZTUuLmNmNTgwMDgyMjE3NCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCkBA
IC0xMzYxLDcgKzEzNjEsNyBAQCBzdGF0aWMgaW50IHNtdV92MTNfMF83X2dldF9wb3dlcl9wcm9m
aWxlX21vZGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGNoYXIgKmJ1Zg0KIGRvIHsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgc2l6ZSArPSBz
eXNmc19lbWl0X2F0KGJ1Ziwgc2l6ZSwgIiUtMzBzIiwgI2ZpZWxkKTsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgZm9yIChqID0gMDsgaiA8
PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9XSU5ET1czRDsgaisrKSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KLSAgICAgICAgICAgICAgIHNpemUgKz0gc3lzZnNf
ZW1pdF9hdChidWYsIHNpemUsICIlLTE2ZCIsIGFjdGl2aXR5X21vbml0b3JfZXh0ZXJuYWxbaV0u
RHBtQWN0aXZpdHlNb25pdG9yQ29lZmZJbnQuZmllbGQpOyAgICAgICAgICAgICAgIFwNCisgICAg
ICAgICAgICAgICBzaXplICs9IHN5c2ZzX2VtaXRfYXQoYnVmLCBzaXplLCAiJS0xNmQiLCBhY3Rp
dml0eV9tb25pdG9yX2V4dGVybmFsW2pdLkRwbUFjdGl2aXR5TW9uaXRvckNvZWZmSW50LmZpZWxk
KTsgICAgICAgICAgICAgICBcDQogICAgICAgICBzaXplICs9IHN5c2ZzX2VtaXRfYXQoYnVmLCBz
aXplLCAiXG4iKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcDQogfSB3aGlsZSAoMCkNCg0KLS0NCjIuMzUuMQ0K

--_000_DM4PR12MB5165C69F5EA65AC2ED8A49638EC49DM4PR12MB5165namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"DengXian Regular";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
span.searchhighlight
	{mso-style-name:searchhighlight;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span class=3D"searchhighlight"><span lang=3D"EN-US"=
 style=3D"font-size:11.0pt;font-family:&quot;DengXian Regular&quot;,serif;c=
olor:#070706;background:#FFEE94">Reviewed-by</span></span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;DengXian Regular&quot;,seri=
f;color:black">:
 Kenneth Feng &lt;</span><span lang=3D"EN-US"><a href=3D"mailto:kenneth.fen=
g@amd.com" title=3D"mailto:kenneth.feng@amd.com"><span style=3D"font-size:1=
1.0pt;font-family:&quot;DengXian Regular&quot;,serif;color:#0078D4">kenneth=
.feng@amd.com</span></a></span><span lang=3D"EN-US" style=3D"font-size:11.0=
pt;font-family:&quot;DengXian Regular&quot;,serif;color:black">&gt;</span><=
span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best wishes<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kenneth Feng&nbsp;<o:p></o:p></=
span></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> Deucher,
 Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=CE=E5</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">6</span><span style=3D"color:=
black">=C8=D5</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;color:black">
 22:07<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
</span><b><span style=3D"color:black">=B3=AD=CB=CD</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Deucher, Alexander &lt;Alexander.Deucher@amd.com&g=
t;,
 Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;, Stephen Rothwell &lt;sfr@canb.=
auug.org.au&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> [PATCH] drm/amdgpu: use proper index in smu_v13_0_=
7_get_power_profile_mode()<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">Otherwise we get an out of bounds access.<br>
<br>
Fixes: 878205b8c170 (&quot;drm/amd/pm: enable workload type change on smu_v=
13_0_7&quot;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
Cc: Stephen Rothwell &lt;sfr@canb.auug.org.au&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 8e576054bee5..cf5800822174 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -1361,7 +1361,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct =
smu_context *smu, char *buf<br>
&nbsp;do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(bu=
f, size, &quot;%-30s&quot;, #field);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt;=3D PP=
_SMC_POWER_PROFILE_WINDOW3D; j++)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size +=3D sysfs_emit_at(buf, size, &quot;%-16d&quot;, activity_m=
onitor_external[i].DpmActivityMonitorCoeffInt.field);&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size +=3D sysfs_emit_at(buf, size, &quot;%-16d&quot;, activity_m=
onitor_external[j].DpmActivityMonitorCoeffInt.field);&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(bu=
f, size, &quot;\n&quot;);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;} while (0)<br>
&nbsp;<br>
-- <br>
2.35.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5165C69F5EA65AC2ED8A49638EC49DM4PR12MB5165namp_--
