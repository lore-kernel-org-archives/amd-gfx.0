Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B31CC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 04:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DBF23159
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 04:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DBF23159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B933C6E131;
	Wed, 20 Jan 2021 04:51:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 936936E131
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 04:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKXOZ40CFKdZShcE9VMxg7S3Y0gIduOUYjTboqKrJD7pg0p19L8fKJa39ASd5cMF8xr9JnLg68HAyZakpfIuXFWEewKyf+7zrU4t+Z4d0dt2brWWhzZXbfBxXUoh4xHk0QHWkD1pkN9ZSLp86TfVCCh3h9SDdKbbowtbjdrss80TcCuggARmietO5CHM6fpITqFUSOdJMaRaEttN9DoLID4l3ZEHeGAyVAtsZXxTpFnjgFGZLFm9+H9EkHooWxZeU/7l2s7EUt3gNvP37FScFVtXNrY6BrHHSxobWyfEa/eMp6/48F51Y1+NQxR81PuMK03eiGMJE36LDYT2AsHxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eRRsvsOnYhFuMbjCKAO5TidQteC4vbFGkrkU9HdqJ8=;
 b=h++hWu8LvbXKduvpo08mr7w760YbZ+a9oYSxPrRLoPDh5R+8OEjVCVbDTe1gMpCcILGrYNCRjWR2A2faYpTT1FWEqKQWnH509ockHZNNJSDdTsAfqnM2tLOATuLZ7cqOm5n9gvtU9SGFf1ZDM8T/738hXeXY+KGnMYNxEuP5zKXysJkHRHp2CDWDHXRu8h4mbpnM6gQak6UuxNHBB/AU4FHsbVZSvSBhTIl/SMz9yuQ8JvMCokjeKkr0cBWAmgN00u1kg123JmYIj4lTGUlWpg9wr94bZSygbM98b9wCpk6A1pOmso2JImwBj2Pzu/sdcygXLNUSYNVKZ2QM7BZ5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eRRsvsOnYhFuMbjCKAO5TidQteC4vbFGkrkU9HdqJ8=;
 b=uV1KZNk3zSnZPgINuLqVeTV4V47+8qExpmwMSgwPp2QzGjxhJmUNnHH+iEmBmfy7xe2QjzAFDIBsrykY38tZax7gFpFzpkAJTFDftPQhbowu8IMy8FXVAjd86jAFe44wFpJtsWBjzw4I71o4DoX6TigsVi0SEokRygOBoOyi8yQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0182.namprd12.prod.outlook.com (2603:10b6:910:18::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 04:50:59 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 04:50:59 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/ras: Fix bug disabling DF_CSTATE when injecting
 xgmi_wafl errors via debugfs
Thread-Topic: [PATCH] amdgpu/ras: Fix bug disabling DF_CSTATE when injecting
 xgmi_wafl errors via debugfs
Thread-Index: AQHW7uc55tdlYy1gBEa5AblCv+Ro/aov8UQw
Date: Wed, 20 Jan 2021 04:50:59 +0000
Message-ID: <CY4PR12MB12875B65B55D19BC209370A6F1A20@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210120044608.4645-1-darren.powell@amd.com>
In-Reply-To: <20210120044608.4645-1-darren.powell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-20T04:50:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f661910a-a6e3-4997-8dd8-fa4542eadbba;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e17d4873-e27e-4921-c779-08d8bcfefb48
x-ms-traffictypediagnostic: CY4PR1201MB0182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0182C1D9F7914A2E2170B539F1A20@CY4PR1201MB0182.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5nLGelUL2nEaHDqsWHkeCbtbxp02PwPQNeCzW4jT6TTNQhUjo2WrGuQHC92PqmcgJqrjDR6HpqmqPjunho2VWP5oaSy7yb5N2J1i4WbEES0+S0xHjWj5o45PkiO7m7w745JXPeXvXwnWZ3zkTusTM2jJdvRVPBjUT97t7VUyPWSiOvE7LvsgxYmGrEDbepFoJinFyQpPpts9RtLzg3QiEYe8WffC40MO3XvUvKB9C1y3NmjCk9avSeNpYtPr9ZbajftDMWFcHOZ1q9Z80AQ7ctnCSzkdwC8osTtpLgmVhxsQVzbO5jCEwU23onF2fQJK6WLmO+AWwdEH8be15f7ygn4KT7wjUQfRyiH5sju6IsayLQe3rYyzF3tgeg6WswSG0vxOjVj4tdyrWFeupNDvU0Q7t/YpGzR24zTvpthku2c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(26005)(7696005)(2906002)(52536014)(4326008)(55016002)(8676002)(186003)(45080400002)(83380400001)(478600001)(71200400001)(66946007)(76116006)(6506007)(5660300002)(8936002)(110136005)(86362001)(53546011)(966005)(33656002)(316002)(66556008)(64756008)(9686003)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zf/LYtof1m+WELq63mePupCELj+JWj9sX+sjQNsPSGLQOtZeXkO3e0KJrDvT?=
 =?us-ascii?Q?GhZWE3QFaVTpDYMiMUV6dO1r4MWSeAaCiLZEp8sfuje21YMAFSFBUi5y0FW2?=
 =?us-ascii?Q?aE7/6F3UKYNofxHGboe6twOEI15OJTJ9LutPlw2s4TumW7RZM89NzkiE/6FZ?=
 =?us-ascii?Q?6/OV6kIjHnCxm7twcypitF/L3dR6MfnyjzIckCB+OhnDrhov4RZGQwuVxqD7?=
 =?us-ascii?Q?y2KvMfGrTCSV9MtmIWG3FsHFtuZ0mpBBLlBPrd5biA+OjOzd4kaIgArYD7kz?=
 =?us-ascii?Q?b+7GAOM7fSs7QPRhOOR0+J/tuJAAEu46CE9Zvdsd1k/GDtCLbYWf1BSnivX8?=
 =?us-ascii?Q?BXFEIbM9BlMZei8zNYndQdRWyVEQXHPfYJCtAPWJxMTM5YjlKp5+DdwWm+Dy?=
 =?us-ascii?Q?y5SBFwQPCxQuoHWwqBUiKHMthUjJCaNNGMxu+Z82hJ8OHa/sGLj+2H9z3w5b?=
 =?us-ascii?Q?MzbnzCF4ntCwyQMtkK36yrsr7M6vAEJqDazG39M8whZSI9+k+fgUW+88Xm5R?=
 =?us-ascii?Q?v5Fgtakdh9gxZGecNYYPCXS048xLf9nwADewfaqg8L/52vSKlENkV+1IgIV3?=
 =?us-ascii?Q?HMqxYlSz7R9/DlpvhSSj91PlMyKKFxruYUlZE4FagtZRsYvtvyu83w2f6VaF?=
 =?us-ascii?Q?/0AnWcwhg2oyANEB4PcgMlZ4Xo3itAdl+I6TBuutNTsN8X00SX1dGGbbbxGd?=
 =?us-ascii?Q?63kztuDgu11fBSrVkFaJh7emnJ9IJbaJTGvwteK+Dd1t1pdDMS8TqtTV693U?=
 =?us-ascii?Q?I0R4e4696cL8Tko/XtlvdndlMzEOOBnR1jh5K07oHJHRXhX6FHMFmEL6meTZ?=
 =?us-ascii?Q?659WkCwUqie2/fyK+ggSUHE8/mzcRtLIaReeHwkMryktPqpV4ilyIdp1NH/t?=
 =?us-ascii?Q?wG0DMl8B6Uxb3ufmS5wBRiNEzRILPV/VLlpyHoFE+dGeyQ0/W9DQdPsRTr63?=
 =?us-ascii?Q?QXrKxJ2wR+WUwmgChjm9tdM3U47qKxgjNMpW3WoSmjM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d4873-e27e-4921-c779-08d8bcfefb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 04:50:59.5841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnrQHZc45+frx1xICtVwP1UGVjbuKH//pnNXkmc0PlZWcq2brj7vkMCTIx4th3aYLb2ZHePBSJbG2jGWkSOZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0182
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
Cc: "Powell, Darren" <Darren.Powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Darren. We have the fix already a few days ago.

drm/amdgpu: toggle on DF Cstate after finishing xgmi injection

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Darren Powell
Sent: Wednesday, January 20, 2021 12:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH] amdgpu/ras: Fix bug disabling DF_CSTATE when injecting xgmi_wafl errors via debugfs

Typo in amdgpu_ras_error_inject_xgmi() does not set df_state back to ALLOW after test this can be tested with the command
     echo inject xgmi_wafl ue 0x0 0x0 0x0 > /sys/kernel/debug/dri/0/ras/ras_ctrl

Fixes patch 5c23e9e05e42b5ea56a87a17f1da9ccf9b100465

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..a6ec28fead07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -846,7 +846,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
 		dev_warn(adev->dev, "Failed to allow df cstate");
 
 	return ret;

base-commit: ed94c622f91453aaca80029b0afdd2551a12e777
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cf1d970cd301e450a074508d8bcfe5a16%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637467147916210362%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Qp1VIuGOhTZPpfHSwnbMbHycrFqhaxIgN3AZkkiHF6g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
