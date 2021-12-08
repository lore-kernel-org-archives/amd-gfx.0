Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D12C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 07:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866A16E0DA;
	Wed,  8 Dec 2021 07:34:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9206E0DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 07:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfkFOiqYR2+68qi9LoaljFgYHTxl3eVP5xPxsiErhd0IMMRlBwFBMUcqaXgbE1G9K6hFapH0cM72q/z26HzEfz/lG5LfmMUSWbSNvDeg9Nw6NYgnBJe3WNshWlz3VZNb84G2k2z6OlsN8kA2HbbcgnwSq6KLknZHmgbMxZ3ok1jJ+3DK+IQrq7HhmKRkt+t3faNsC4kcUc0hx0PRWMnK0OJT6ZhwOKgr22INlnFq0elk7icr2gQgNkFtY7694mm4gpfIpHHaoXH5w7hemmvC1pWiocWuMGFoqCN7zQpobi29mV0B0djfeWXtbCYmDQi+j8YUwcXsjmpEmhqCXSikZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUKKef5XFjXhv5vJaYMDZAXCwvmTzZNJcwF1WMDOF6U=;
 b=WamKIrCW8MoUH6BqWkmLTt42gviAvQXhhNI0p7AdG8yyDWLNrtiiKXhQ0/Dged8j1UWlvSiayRhqOk/qyf+VKV851MRnTtkxOXCuBgdhOc+Kgt4rMkzv37HO7eefnFhF78qy8XQVHk4xgA3MhbAZhzZ6zzvg2n7LjiO2+DJol82Ppn9+d6nRo2kLwrxXOZmodD4DyvMmvfMgI3bkCr5rk4FR0QomUZdVabawErV2/O287YU2Fe0KwfFSZpqV//bP5A7uCHXWCO4uJ7aP/yHpVJbruE7SUCtb6PPG5bnTwRijtW5RU1LEhHXZpZT5X7hosk1oOqrPgksdtbkf0Fzr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUKKef5XFjXhv5vJaYMDZAXCwvmTzZNJcwF1WMDOF6U=;
 b=MptdDgHjQAElLyVk+7HnPf0wV2IYHyEfEy1iTMm6NaOB9gR+QnuOm5bb9vNu5o/doNHzd+VwR01aH9qMJqfFzqMeeu8wExQWkCrNGRAFoNQm/cYj2v6HLfD7gsE4NWX4yaVmFfBRocW+N1LRUG23H5IwnWVPWkiomDUooRcCrZg=
Received: from PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Wed, 8 Dec
 2021 07:34:00 +0000
Received: from PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::acef:ade2:769c:1685]) by PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::acef:ade2:769c:1685%5]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 07:34:00 +0000
From: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected
 to CPU
Thread-Topic: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected
 to CPU
Thread-Index: AQHX6/u0j1lM45rI5EGmPOQUsOZt06woJl7AgAAKKQCAAAIwkA==
Date: Wed, 8 Dec 2021 07:33:59 +0000
Message-ID: <PH0PR12MB54511E04E18BB7B36573BF49986F9@PH0PR12MB5451.namprd12.prod.outlook.com>
References: <20211208062020.6445-1-tao.zhou1@amd.com>
 <PH0PR12MB5451A2FD1BB367183E3EBA78986F9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <DM6PR12MB46508B6BF369315A31BD9B08B06F9@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB46508B6BF369315A31BD9B08B06F9@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T06:46:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c138d4a8-7fbe-4039-a37f-118cf9372bb5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-08T07:33:54Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d4d52464-68c3-45ed-b786-742e27179a92
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac4ef9f-9bd9-43ee-00a9-08d9ba1d19e5
x-ms-traffictypediagnostic: PH0PR12MB5401:EE_
x-microsoft-antispam-prvs: <PH0PR12MB54015400D1BAD4AE2898AA7F986F9@PH0PR12MB5401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sE8xO/86APuuxyC/O4gC99yY+CWwBsWkaddnccHFdHLYXTxWRfYUP8uLw3IW6KeTeXD8lq94Lj3mH1bzMfVst0dbd4/jAZHDk1e1uAj5qenQRxviD+uqeIplGxwJx6SG9zknDL4MydJZAepT6uUbhFC82aHzRs8b1T9uQB61lmgEFFJrv6U/8GwO9J3FeXWa3QkfS7qLAIUgGxbfv0oFyRSf81ipnm2OIsvfJp3L7tAr1+eqywguYsakvUnitDpNul/A76dKpXhBRSe6GCCB7qySl+1+alUoMShk7HVhZTJH57dhquOckUclrJgCFjSA9GIN9qBjaGWKjdkmtmz7z2RWqUDN16huDHvhMvKFRe8WOumyzkbOULnPjirb20GUKhUjMG1Lo5TT3aB9PALwqZ3dZB+PFEu0Piynt8cMXyAdCCREHSXuBG7iWSm5x8Bp66nWO28GgzrcE9WaqX3N0klBzyVgpyWAvOsYiZ57TWlq69aHcq327FbW9hqCfXI6ZYGS1rVnPEYT8HYEF/9cc3sxx6ntlcH7VoMpqOyFN//kufVk9vwtnbdGdH0GS3TOxvwBhs2NdkdemgcLq1OqgM7LSKbAPZsBWivGwNJ39lOHPRTXxhBok3K+3Ra09H3ss0yhRZeB99MVssPdYnCU4/MHcZquaA9/Y6Yv3IRKNA06Oa8/8ZxyWa1RK+toF3q7VliGEwWMUmmcuRDbfNkLtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5451.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(66946007)(5660300002)(55016003)(76116006)(66476007)(71200400001)(66446008)(8676002)(66556008)(64756008)(110136005)(38070700005)(53546011)(2906002)(83380400001)(55236004)(122000001)(6636002)(8936002)(52536014)(186003)(6506007)(508600001)(86362001)(38100700002)(33656002)(26005)(316002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lhTklN+G45WCUZ22PWgG+0tdty0wohLsuwBC5GwoJTd036zNyXFlKvOPG47P?=
 =?us-ascii?Q?7/eiVtmfy77On99AyGEbtOPxi/NjF98wUZEIiJI/lo31E7dmFDGOBNmgO240?=
 =?us-ascii?Q?Uk1hqibXYyCPAHhAHgLWR7w5IF1uaKzyMkgPTv9A1Yk5YSyQBZwFlHftSrUq?=
 =?us-ascii?Q?McnmFFPURaJ2avZEhHqYoWUWi7Vno2Z7AmYFEBshPmThUu6C4Q69Bof71uM6?=
 =?us-ascii?Q?fDUYjuYqVPWhnjxKKR8WBqVI1Jv6xJiUr/9IuixqILEk4sbSJVgSqR5GEuHA?=
 =?us-ascii?Q?B8MejnY5g89NTzak4NoAfflCpPJfvm1wlfzD/2M6kodyWA6imUKbW6O8WG2X?=
 =?us-ascii?Q?deUbC/Zzn+jUIiwx5o7i/QtvKUtx1Ct65G56/qvHAriZFQnQu0sbJh63YAkY?=
 =?us-ascii?Q?NDBG48+yu5p1XULHCy1RlNEKh17tvLRiuPae2XbUAT+9vdsPVlhoR8L/qNgh?=
 =?us-ascii?Q?7eYSGtL7tE7ZLpoPv1Q2CJJ5t9NqR2VjE8wLzwNUbgyx6y0s7elFm48sX+vw?=
 =?us-ascii?Q?Lo54HnG3uvrKdAbVsqTASBrqvL1kTMzwZPp7nZIOhTzg1SSLDiAkaW5OaR3p?=
 =?us-ascii?Q?25BH+KjSSWj2YIKhnrQQY9hLnst0Vb3e2PVA07OhxX/+NTj7MX176yFqTSbQ?=
 =?us-ascii?Q?TqhFaj6QQtZx1Jujtez3d7tM1+3tpXcompCOb0pWDXuqhvNxNV5G/IhF+MdO?=
 =?us-ascii?Q?MEGJLJh0mqlWUo8tkO9XaAP5sc0ysgBjEDrS8wEnNi3i6HkZ1iK59IqHlcef?=
 =?us-ascii?Q?s9gUJYzK+4ZSE8XAeZ6U1s1BJeJ6BGyttxEYV8CijqlsHiSG+YW25BBpdEiE?=
 =?us-ascii?Q?FEgicEt06BeD36T5+nJQoyAjX7ZgK6BMoSVMRidz0gb4AUxXuFxuLaiLDXaI?=
 =?us-ascii?Q?YoFh9BZFFIGBjJlHxPt39iDYDMGhNy/b5xOsMjzE6nnrVAYPQKh9UuQ9Ew6R?=
 =?us-ascii?Q?AEnOAFPGKmtNajjblKbsMoPVjsv6FIQOCo0o60jk76MGoINErEhsGe9+jTCw?=
 =?us-ascii?Q?RYx9bjWduBEqu8erV8fodX717a8nSBmJF6hrLo8fIu6JpdeluXFIF6AztcUG?=
 =?us-ascii?Q?iM2xjnP2j8+ExauNvrVaV+n+GPi/jn+yxYFdP3bNe2shk18mEXqbrX1yuPHX?=
 =?us-ascii?Q?P8Ex5JdUXaOo1NFUO1fpD4r6mAPfu52kfaQ4vz50+pnXGvyIxFI96U1KGpqG?=
 =?us-ascii?Q?Xh4DGnJvWFVlJ/5vZUhO3B6vwwaB5MTpaFhNkzz9CGv26dtSQWLN7zPI7Har?=
 =?us-ascii?Q?b56gB+21iWcAVc5vo0GlftH+1//GCx75ySzeplQNY7TEcSV2qs8L/qc7/VDB?=
 =?us-ascii?Q?kfSqZgpoGlYgDwvYqltBfp1KWESaBDzSwiJz0uG4EUmfm/RXKTJs/60dok5+?=
 =?us-ascii?Q?fs1Wt14QQNF3pw3TF0H8ZS+4Z5VpUIZaJQ4WBo1ga3taN1pi7g3FRvEcv7ms?=
 =?us-ascii?Q?Inv/HsxdgPvD7dKxPJHgGCnWnLCHKsS3iW9/384+gB8afcZ4U9Nnbjf+Whsd?=
 =?us-ascii?Q?iaUZcSuaFAEpo8WZisQBPt2oWDRq2AmugSkDA5ijJZPoMKIVKYfCwxYfNCog?=
 =?us-ascii?Q?FICzaybZX8+4BQ3kuko=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5451.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac4ef9f-9bd9-43ee-00a9-08d9ba1d19e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 07:33:59.8841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZUcGBfWjWfiNL5gBI6NI8knHQvMIESDZmEx/tLeM5rCg+DIV9jztWiUVTbAWuTV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
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

[AMD Official Use Only]



>-----Original Message-----
>From: Zhou1, Tao <Tao.Zhou1@amd.com>
>Sent: Wednesday, December 8, 2021 12:52 PM
>To: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>; amd-
>gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is
>connected to CPU
>
>[AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
>> Sent: Wednesday, December 8, 2021 2:47 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org;
>> Zhang, Hawking <Hawking.Zhang@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is
>> connected to CPU
>>
>> [AMD Official Use Only]
>>
>>
>>
>> >-----Original Message-----
>> >From: Zhou1, Tao <Tao.Zhou1@amd.com>
>> >Sent: Wednesday, December 8, 2021 11:50 AM
>> >To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
>> ><Hawking.Zhang@amd.com>; Ziya, Mohammad zafar
>> ><Mohammadzafar.Ziya@amd.com>
>> >Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
>> >Subject: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is
>> >connected to CPU
>> >
>> >The RAS poison mode is enabled by default on the platform.
>> >
>> >Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>> >---
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
>> > 1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> >b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> >index a95d200adff9..0003f2c64da8 100644
>> >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> >@@ -2372,7 +2372,11 @@ int amdgpu_ras_init(struct amdgpu_device
>*adev)
>> > 	}
>> >
>> > 	/* Init poison supported flag, the default value is false */
>> >-	if (adev->df.funcs &&
>> >+	if (adev->gmc.xgmi.connected_to_cpu) {
>>
>> Why not considering PCIe interface connected device by default? PCIe
>> interface connected device will not see this issue?
>
>[Tao] What do you mean by "PCIe interface connected device"?
>I think the else if path can handle other platforms and the default value =
of
>poison_supported is false on other systems.

[zafar]: GPU device connected to CPU over PCIe link without XGMI link and V=
BIOS flag does not support UMC RAS error injection.=20

>
>>
>> >+		/* enabled by default when GPU is connected to CPU */
>> >+		con->poison_supported =3D true;
>> >+	}
>> >+	else if (adev->df.funcs &&
>> > 	    adev->df.funcs->query_ras_poison_mode &&
>> > 	    adev->umc.ras_funcs &&
>> > 	    adev->umc.ras_funcs->query_ras_poison_mode) {
>> >--
>> >2.17.1=
