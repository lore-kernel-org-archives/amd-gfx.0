Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EAAC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 07:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71224216C4
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 07:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71224216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AE3892E7;
	Wed, 30 Dec 2020 07:32:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680075.outbound.protection.outlook.com [40.107.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7ACB892E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 07:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9na2c0PZcgho4h2pH9xHWvHNHUhktO5JB2HqRsUSjVrD/iSmVNOmG2GC2W3GNka05IHCTEL99kRkZQb7zuoTyqQvwLJu9gYOHDNwaa4LztSFJgxrTt+8t9pgoOHy+UDluHG8ouGz1ut2NJetqW8WPZ3hbAyWqGu6BJ7P5dKZKR9wt7URaCmcEuiQxg5joGlu1wqZuwn5BIAdJ/8JR7mg5Fe4rzfMt1ZYmaBNzaH+51Bf3ARzp5hnBF4Y4WURXKD6hG0SBL5jjlXKa8VqpiaLt/5dHecEVtn5gLv1Kheb9cCU8coM2gre9krZrc1I3lGZcfh5VBEHj/Le9ybvrPEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WaqDzezoasqb/27mAQEoH4reHTZpGCPE/Jih1TeOrc=;
 b=TBy2GTCwINE1yi1HnHk6LVZHpUsevekJGPlLCyoy8q1aV7UJHzUcQVbbhF6lF2vZn3S+jJkIUmtwhCWFtijXt1EBAqBcRONeC9wo8aBMdsVT2Mwn5vUgU+zER7Echu/qLGlUsKBB3bnogE/Z6057OF9h5XFggzuPcd99G0x31u1RV6pgii90ixRJJE9Qo+NJ8jIKFa+enyCoyQkdR2xy8jugNswc+ZV4xXflLoxUw9NjYliO6o7y0zFG8W8itPdFwZKde4zqOwab9Rjvg/woHu7CkNrtb8lohMuwvDGad8QRaOE9Ekua4llm+LZf5+BXl73ZvZ2uk7RCgzUbXPj0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WaqDzezoasqb/27mAQEoH4reHTZpGCPE/Jih1TeOrc=;
 b=ArIgiRhwDea2hgTBQD8pd7kqDrPOuXIhrXdQZs2oKyqiUdaz7MYTJY43C7OgMqKxeAJcWpsnIO/GBN9JGe7ClYAWWzzjEt4iWs5uXdHyk1HYn0XnPdgrBE4kHuBq/fOknwlkYwtqcTTVCGyW8QIWuR4NliwRq5kYiAn4+GPfRKk=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB3780.namprd12.prod.outlook.com (2603:10b6:a03:1a2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Wed, 30 Dec
 2020 07:32:14 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c%8]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 07:32:14 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a memory protection fault when remove
 amdgpu device
Thread-Topic: [PATCH] drm/amdgpu: fix a memory protection fault when remove
 amdgpu device
Thread-Index: AQHW3ndsvQ8AQfOeEEWrNDxl+s0BdqoPPAVA
Date: Wed, 30 Dec 2020 07:32:14 +0000
Message-ID: <BY5PR12MB48851543629CD6A9A95E55BAEAD70@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201230064534.6224-1-Dennis.Li@amd.com>
In-Reply-To: <20201230064534.6224-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=42e198a7-7ead-4da3-a4dd-9e052b976dcd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-30T07:22:05Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3379f0f7-3c15-4707-f9f4-08d8ac95071a
x-ms-traffictypediagnostic: BY5PR12MB3780:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3780828C429E7ED2EEE52BFDEAD70@BY5PR12MB3780.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GG6DEKsxEhJ+kDAEW/WB22lrvAPfZ5SwxaoAG9H5H45oFfNyphCPLPwSyJt33gO0TNHYqT0EEQ12CZKNecdKfnDO9oy50hUm6hFDcTTpcV814mF7SS2Wbt/IeS47TbqathMAEhpNciYzt4/fJLzYyoB31XQiQ2Tx6E+wdJ9Xe5AybznLICn6dmvDVrzw+raenkGUT4XZOSKm0FtQTBUdobc5P1epl+iP0JzozqO8E00kzPmgtRk/JW1szBOjoymrPSnhoL4iUU89LyQXrutwB99BgrwqI5DzMeKVcjnE9o6gPgeQEHD8ZIvTE+HkMdcVCQqcGgoQPTTlbJ3tGtTugGwdfJmwBoLiXafBIxn1S999/koRpvc1Y+BqzDFsgUOKVd3CB88GQmT52G7SzwBPP3B6TyIhAn9ZwebBfvFJ+x4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(66476007)(52536014)(76116006)(45080400002)(71200400001)(7696005)(966005)(66446008)(66556008)(316002)(186003)(55016002)(64756008)(4326008)(110136005)(478600001)(26005)(66946007)(6506007)(9686003)(53546011)(8676002)(2906002)(8936002)(86362001)(5660300002)(6636002)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yv4vV96zE6sXAk/KW90VtRuGfoTdW1h7wHgHHF3JmtRUhpt71HU/nrraqijN?=
 =?us-ascii?Q?jEzt7ndQXCaKdLT9VGy3vEiN91HPueMk7KHtO3VyFSC6faq8qe3dHOfW1aVZ?=
 =?us-ascii?Q?x5lpDq/0qYZrPviF0sSpQWi887Xa/0RUkBCezEAlXyVl3n4TXRox2xQzUxGe?=
 =?us-ascii?Q?ERJDd9+bvP1ZZXpxUp/3z3qDgZPxRl/BHu1sGa2Nupvn+kiqinkhRvPeEq7N?=
 =?us-ascii?Q?iDbmmbkxIJX2R0faUa8JlHX7cS5v/iQo7UX5hBCrKR1FjFDjykXWtvsVgVVe?=
 =?us-ascii?Q?wPIXD8BC8y+vqcrS9bSf2r2gPzd4klrNuVrLFUzVBRKJHV1WtUOY/i4bvw9y?=
 =?us-ascii?Q?nSwusIwLrtIm/vWwo70AkVVQa5BpY6Ck0lz68JlIXOd6eXwy0RSxcL+nsd2k?=
 =?us-ascii?Q?pe1F1Juq/Gn4sVOmSx5KJ4J2JI5TJSDxtsNj6ipMJi2xIKhyPz9pOzjD6Qtb?=
 =?us-ascii?Q?xnXR+X8QKGMt3X/W2FQYa3riC3qNyF7LUIkW0KMQVR3lGtKAAwkOt4LDlM/6?=
 =?us-ascii?Q?gzVtsWvrfUht0GF8ntGRo/NGCuzYuY8ipWI5TEHHTmp3aEwa45PqqPch+Rr9?=
 =?us-ascii?Q?cWKNZzxhBICrB1Z2h+bTLrtH0UtJUUcqNq3+KmDv5qnL2kIpocc9H9ZdTjBm?=
 =?us-ascii?Q?I2Bdp0evB6CfwdRvnqTIJBrFFWpFvvOKiCwh1QCZpQQ/Fxtn35nmlVO8PEw+?=
 =?us-ascii?Q?3kz20su4udrtivTYmmV1gQJFNWjD7YPYaXpeZjT/5quQNyb395cGpTbZG+2H?=
 =?us-ascii?Q?uSWoofhvynCrG2HnBrJzlN+oSbnHN8Wxrwq8UGZkZz0wGRRtNGswngAXkIgE?=
 =?us-ascii?Q?Agz5bGwjxn1MXGKJNnkAsiBI0tXcETJQC1FGRC+NxTkDQYQwsFaMqgR81+a/?=
 =?us-ascii?Q?F1WHXmymq+DjivHt9wNPS0pUe86Ii65UUhXec5AHAJ+XRbep0fBQq3cfSHxw?=
 =?us-ascii?Q?+gQeVsNejnvr2WMX6GD5kPxzGgCHhwiPwghnApLnonk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3379f0f7-3c15-4707-f9f4-08d8ac95071a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 07:32:14.0904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ebdb91r0j4mn//JVSNUU+yUvx6Ywm63v0JtjONZtcNiwpnIZPEfsuKZAos6yx68zxKTmp81kf70Emu+3SWsGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3780
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dennis Li
Sent: Wednesday, December 30, 2020 2:46 PM
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix a memory protection fault when remove amdgpu device

ASD and TA share the same firmware in SIENNA_CICHLID and only TA firmware is requested during boot, so only need release TA firmware when remove device.

[   83.877150] general protection fault, probably for non-canonical address 0x1269f97e6ed04095: 0000 [#1] SMP PTI
[   83.888076] CPU: 0 PID: 1312 Comm: modprobe Tainted: G        W  OE     5.9.0-rc5-deli-amd-vangogh-0.0.6.6-114-gdd99d5669a96-dirty #2
[   83.901160] Hardware name: System manufacturer System Product Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018
[   83.912353] RIP: 0010:free_fw_priv+0xc/0x120
[   83.917531] Code: e8 99 cd b0 ff b8 a1 ff ff ff eb 9f 4c 89 f7 e8 8a cd b0 ff b8 f4 ff ff ff eb 90 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 54 53 <4c> 8b 67 18 48 89 fb 4c 89 e7 e8 45 94 41 00 b8 ff ff ff ff f0 0f
[   83.937576] RSP: 0018:ffffbc34c13a3ce0 EFLAGS: 00010206
[   83.943699] RAX: ffffffffbb681850 RBX: ffffa047f117eb60 RCX: 0000000080800055
[   83.951879] RDX: ffffbc34c1d5f000 RSI: 0000000080800055 RDI: 1269f97e6ed04095
[   83.959955] RBP: ffffbc34c13a3cf0 R08: 0000000000000000 R09: 0000000000000001
[   83.968107] R10: ffffbc34c13a3cc8 R11: 00000000ffffff00 R12: ffffa047d6b23378
[   83.976166] R13: ffffa047d6b23338 R14: ffffa047d6b240c8 R15: 0000000000000000
[   83.984295] FS:  00007f74f6712540(0000) GS:ffffa047fbe00000(0000) knlGS:0000000000000000
[   83.993323] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.000056] CR2: 0000556a1cca4e18 CR3: 000000021faa8004 CR4: 00000000003706f0
[   84.008128] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.016155] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.024174] Call Trace:
[   84.027514]  release_firmware.part.11+0x4b/0x70
[   84.033017]  release_firmware+0x13/0x20
[   84.037803]  psp_sw_fini+0x77/0xb0 [amdgpu]
[   84.042857]  amdgpu_device_fini+0x38c/0x5d0 [amdgpu]
[   84.048815]  amdgpu_driver_unload_kms+0x43/0x70 [amdgpu]
[   84.055055]  drm_dev_unregister+0x73/0xb0 [drm]
[   84.060499]  drm_dev_unplug+0x28/0x30 [drm]
[   84.065598]  amdgpu_dev_uninit+0x1b/0x40 [amdgpu]
[   84.071223]  amdgpu_pci_remove+0x4e/0x70 [amdgpu]
[   84.076835]  pci_device_remove+0x3e/0xc0
[   84.081609]  device_release_driver_internal+0xfb/0x1c0
[   84.087558]  driver_detach+0x4d/0xa0
[   84.092041]  bus_remove_driver+0x5f/0xe0
[   84.096854]  driver_unregister+0x2f/0x50
[   84.101594]  pci_unregister_driver+0x22/0xa0
[   84.106806]  amdgpu_exit+0x15/0x2b [amdgpu]

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: Icc981a421499dff844855d5a662e91d1730c2754

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb19ae734396..b44b46dd60f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -564,7 +564,7 @@ static int psp_asd_load(struct psp_context *psp)
  * add workaround to bypass it for sriov now.
  * TODO: add version check to make it common
  */
-if (amdgpu_sriov_vf(psp->adev) || !psp->asd_fw)
+if (amdgpu_sriov_vf(psp->adev) || !psp->asd_ucode_size)
 return 0;

 cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL); @@ -2779,11 +2779,10 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
switch (desc->fw_type) {
 case TA_FW_TYPE_PSP_ASD:
-psp->asd_fw_version   = le32_to_cpu(desc->fw_version);
+psp->asd_fw_version        = le32_to_cpu(desc->fw_version);
 psp->asd_feature_version   = le32_to_cpu(desc->fw_version);
-psp->asd_ucode_size   = le32_to_cpu(desc->size_bytes);
+psp->asd_ucode_size        = le32_to_cpu(desc->size_bytes);

Seems the above 2 changes are irrelevant.

 psp->asd_start_addr    = ucode_start_addr;
-psp->asd_fw                = psp->ta_fw;
 break;
 case TA_FW_TYPE_PSP_XGMI:
 psp->ta_xgmi_ucode_version = le32_to_cpu(desc->fw_version);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C84cb071ec63b4873b95708d8ac8e8c73%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637449075549697811%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2F%2BnptRNjREYYlH9FWzP9%2BvbKO3AhrV3XoSN6Kq%2Bh%2BQI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
