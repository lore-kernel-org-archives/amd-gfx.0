Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A4FC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 03:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E0E61959
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 03:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E0E61959
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7216D6E1DE;
	Mon, 29 Mar 2021 03:47:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CA76E1DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 03:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuXF7vGDn/bJV+4n/ztFVRwV+15mAEPdNDs6B57JfBzsvFu+S152XLsdOb8PzK4tNXOMmFKbEMb2go7bz4mbdIpTYledjBtnibt7IFoPL0p64F0m0ogdNAEkN6W8s9A16xKGxpMyc7g1ynfsiDMc2f7dGSNMYtkoTyBIOyipQkmnrkduLtVQvFCEAq+QJIMfJpNKyu8jQU9FCHiGIaC1KmXaZHHyQpN+T7h32EBnCTuExzs7xhUmBUa9J4nMzlI7iU+j5KjYF1Qn/1KhiSlWNP0U/WBd6kvZYVcir1XWiHo3sVw8U02zDReHtZPoCgakmcuuwbOxGNh0SYMm71O4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TTzJRnoOLlw8cbXIvamFjdP7AVlLStWJl2P7//b8Dg=;
 b=mITPSL2FLD1jCkq4tY/8ujm7DhN30WVeV84jPHRk0yXabTULYOqcCb9yhvQCtIkPr9h9ltsC/1Zkz6MAIR8tR9WcV93UK2x3+8+wIIHd0YhfKaIiea3iJxsUpU6YWrlpx1exOJXmjr1rMgw+itVrFqbrwWsmR3WYzAPR+whAUB1rrvAMtoOj0aCqNBZPX/cRvhAQ/Vb6GliXLqQtxBEy9UzJc7P3rnsW48II5f/EV5xwkMnASFPPe6gpO618YjZPoXucNnIc3+2hEvXanKMICPdJK2Av4Ef7ta8mRGxkJGhNwI8wPTEk85Zaax8FcDw+ObwUpuTLbo5ou/F5CRzNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TTzJRnoOLlw8cbXIvamFjdP7AVlLStWJl2P7//b8Dg=;
 b=hetui0inwiCyRnsC6iA9SGt0tlvRteGSYtJ/G25h9L+VJFjInhcmwsjbhJ+2XyhhS6RBr6CeScXp1X2mPo57WMbVSQcmg4kaRZmRN5uXYyeh2r3XnwveyONUcCnfQVntbmRT3sSM5XEEPSMNFl8o0Mf84RF9mG3GS/JFJq+XbSk=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB2503.namprd12.prod.outlook.com (2603:10b6:903:d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 03:47:01 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Mon, 29 Mar 2021
 03:47:01 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: set MP1 state to UNLOAD before reload its
 FW for vega20
Thread-Topic: [PATCH] drm/amd/amdgpu: set MP1 state to UNLOAD before reload
 its FW for vega20
Thread-Index: AQHXJE0enlaWnTIbFUOBWzM9U4J7CaqaUqbg
Date: Mon, 29 Mar 2021 03:47:01 +0000
Message-ID: <CY4PR12MB1287F770279A6DD1ED12153BF17E9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210329033843.6211-1-Jack.Gui@amd.com>
In-Reply-To: <20210329033843.6211-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T03:46:58Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e538e618-c253-409e-9a42-0394c9afc566;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52d055d2-0654-49b2-6c6a-08d8f2654fb0
x-ms-traffictypediagnostic: CY4PR1201MB2503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB250353B004A7C9E51C4934AEF17E9@CY4PR1201MB2503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:184;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECxsDGGprxgBoLpngUy5Iqr20X8h4Bq/suENFiYWy/ao6TkifRcdXVcs2MpQgJ4xVx2wI1YYe2dkY91k7y/1jfyR2ByvAhoNK2zxHBApeFAzr3X/K6BB+nzvxkagbkAC0YqR8lsPXIBk8Uc433sPkeAc9V33+hkqdNBpmQNqJlXOzUewLNHZhjUQrf6NtlMgG3/Y5HEfIHlcYlk43phcf0hjFge2GBnKOpsITWipCtoACzNW4EKSr9CY+VS5MCJw4ybZxdWGWKidxaaOnOaneUmOE7xNOsX4J050WJpPfIAEbUNO9QKpqPxrrBXXc2ooNsui9aSPaYhttX3L3mPLcjsjfQSNWAmoFIbUY0bg9OBoLgCI+TOcKrmWQ7O667CVvsaLuQBwp+CUq1kO9olKeyGtRgk0Thj9PeZ6KDtvMX0H/KqhIv/SnBU9WzXZ6GKPvRUfUzkmzWfsTX4q4Xwc5zgSKtAcvWWGBmWPZoTRGa1e+U4eiki/hWlQ6mZCIFg5N67uxIHfBp4IqziP20G9ZLHFIVWPxMLzRH7mZnQjKXHyRZEehL3bZSrqFG/PckAg/sB1UPJiBZ+bAMo9A3Iy4zodfDeVDOs3ZoW8AYt8GmIiVWWfrkH3cNXhhnq8SwjFz66vnHbFl11NXdrmuvzYsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(86362001)(66556008)(8936002)(7696005)(9686003)(54906003)(26005)(66946007)(64756008)(66446008)(8676002)(186003)(52536014)(38100700001)(76116006)(66476007)(478600001)(71200400001)(316002)(110136005)(2906002)(33656002)(4326008)(5660300002)(6506007)(53546011)(83380400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NqHiD6xjo8DLAMKC0mz3VuvDfyZPkPDik7SCOPAz/6LnkwCbXvn/e5V74Zvg?=
 =?us-ascii?Q?wKOkdLiYlFeObAIQZIMsy6r906I2APHikiqhDnP3+F1xbBXeApFbe92dp93N?=
 =?us-ascii?Q?SC5X5oo522tLNCURKZWL5h0M/12RcBOkypErQZlcULfpeb/ahTEvcjbXReht?=
 =?us-ascii?Q?Q4Lo5XUqG+Tzfz0YJJoauNYp55lkztRJKPZXMYxMTfI2Epy23IFp0JvSAYU1?=
 =?us-ascii?Q?Ab7i5642n0dgbHlxalRFf53vs44BgHzMNur2ZmO+0LqSSzm8vQ/0TvPx0P0u?=
 =?us-ascii?Q?CIUWBhnjf0LZqw9zysJtenWCgl5zTgZ1pfLI4oFUCwsC6b8RAg7/HoOTXmcf?=
 =?us-ascii?Q?naD3QuFx2eGAKhfhxMPWTIyBHPrlxacXjcDjWMmhFu60rIJbSJNBxavDhi3m?=
 =?us-ascii?Q?NVqTOa0jMw3ldN7i8VksYW48vnv1yWqcYT2HoeE4Gw81J2bshWGtxb5iWRvC?=
 =?us-ascii?Q?/f/0vwwT/Bkt2pv1SGIpHfx2q2SsX6heYERmGMquzUdMMsNYAnqh6uCu3E18?=
 =?us-ascii?Q?KvYpqY77wAAsKd+kN7N+/xX+P+IC9z3Lr4MlsdavhrG93ytjUfbVpbBgCKGz?=
 =?us-ascii?Q?dLL878YM0cxi507WoFve5ij0W1STjWr6ygUK7HnMiYCfB82TjFzXq3md/+rl?=
 =?us-ascii?Q?f1eiXatnnBgp/zg8t+DS/L6Y2SQBvHmbaAE3ZdFJAYjap71Wdux0StZAjwz1?=
 =?us-ascii?Q?UlqslT4E+9YJUH6XWPWUQodd6nkrIqXc6xUg/paCSyjPK7etFgzTOW6vq2UV?=
 =?us-ascii?Q?i6Yj8nx8kVvV6ogta6xr1t9RqpRPkIc6dt3+o0NDvVJfx5QL7XfuW5Ow+q+f?=
 =?us-ascii?Q?B0E9CNrC9c9IkFYcby40q03eZCjget7oUp0zDgaEgt6NaSzwM27ojY+NJd/6?=
 =?us-ascii?Q?CBq1whwV81GxT/Tbne8jqPaGyXUDb4MLLDEk0j7IWDOFfaAgvB/T584Bvzp1?=
 =?us-ascii?Q?ZgUqbSFfcOyDEyIYH19qbBvgFYAfwt6aUDG3YO0bfXX7XOGfCjzYutBFn6La?=
 =?us-ascii?Q?Gyb4iipDWTLgxXY92AlHhpnvFCm3kZfRntdaVXNwf/VRkTB2psbB/3eRzd0e?=
 =?us-ascii?Q?NrfUPh+h9C79rfuv8lkQcyyMQ4QbiazlPEpz1sK9w7kxHq9WJqWg587dJmIT?=
 =?us-ascii?Q?VUyniDGomFxEb2NPC5ngtsX3L/yWRpt/A8ijARG9l/HGc/h6eRXOzQ9rbrss?=
 =?us-ascii?Q?8hkatC6g1ejEPVm8cH6lIsCKvSbn+DfLFz42CANspTkM+3SuIHRIgEHoOED+?=
 =?us-ascii?Q?Tivrrd6ox3dBccu6vWjrfWP9+MXE/EA+eSGhvczTWAJmVum5Rex74eYp+Zhr?=
 =?us-ascii?Q?2W8FnGe3CUXlUXgFs2O9SsAs?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d055d2-0654-49b2-6c6a-08d8f2654fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 03:47:01.2177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPovJZ3eJmAor33GG8jTrfgMrG3IkQ8SGdOnotbcZPJxeCqKmvkS1rTBBYMwTk6kw9sUVuTq6rT1KCHcqNOJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2503
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Gui, 
 Jack" <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

It's better to add below error info in commit message for audience's understanding.

[  121.642772] [drm] reserve 0x400000 from 0x87fec00000 for PSP TMR
[  123.801051] [drm] failed to load ucode id (24) 
[  123.801055] [drm] psp command (0x6) failed and response status is (0x0)
[  123.801214] [drm:psp_load_smu_fw [amdgpu]] *ERROR* PSP load smu failed!
[  123.801398] [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
[  123.801536] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of IP block <psp> failed -22
[  123.801632] amdgpu 0000:04:00.0: amdgpu: GPU reset(9) failed
[  123.801691] amdgpu 0000:07:00.0: amdgpu: GPU reset(9) failed
[  123.802899] amdgpu 0000:04:00.0: amdgpu: GPU reset end with ret = -22

With above added, the patch is:
Reviewed-and-tested-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Monday, March 29, 2021 11:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Long, Gang <Gang.Long@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] drm/amd/amdgpu: set MP1 state to UNLOAD before reload its FW for vega20

When resume from gpu reset, need set MP1 state to UNLOAD before reload SMU FW

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I54c2accab58d53a2780d10720f26a717bf1ff130
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 60dbb8c1e74d..aa16bc292a16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2148,7 +2148,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
 
 	if ((amdgpu_in_reset(adev) &&
 	     ras && ras->supported &&
-	     adev->asic_type == CHIP_ARCTURUS) ||
+	     (adev->asic_type == CHIP_ARCTURUS ||
+	      adev->asic_type == CHIP_VEGA20)) ||
 	     (adev->in_runpm &&
 	      adev->asic_type >= CHIP_NAVI10 &&
 	      adev->asic_type <= CHIP_NAVI12)) {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
