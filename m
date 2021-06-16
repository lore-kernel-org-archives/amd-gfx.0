Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00A1C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 06:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7393E6128C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 06:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7393E6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6546E4D2;
	Wed, 16 Jun 2021 06:01:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032C86E4D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 06:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXRhXa36VL5nj6yswvNczD9EbzDqhTWg9sTVzN+z3oLTvEoi/YVs60h5G+S7LR6MsfwwHDexvE/WqCI6QhvCxHtU0EpSJZZXldsHE+8mY4OkO5A95fNumQLFLc4hzJKDqknoOEyIQeG0yDjvGv0Kq6KE579xTsAHN76bdFkGutgbOUBXBRLfRPEpBTBc9XwP13J8rjM2teVdBaoEQWJQLXq703eo5i5kXSHOTAQWVIBwvN5LRWKDN9P0q0l3Kyl1vn/wJtRNCffXM4StnhRYxNmaKAs1XnybNY0MsIWivE306OnUHQEdjoRYIvGcMxTRPqjb2QfCy7mzx5uO2bSlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqMglxcggqRF/NxCFEi+MVmLDRK4rLB8fY5yJjDfkQk=;
 b=AW7Q15FFSFszMTaEMp3AJ2SQHWIJFz9yNLOcNpG0AQt9IZ+wWyzfyxphD+DrfeHt1Pgsi6K2afohISajRltR9Ybg6W5q2zB+2T7e/15errEUk3ZXGDGRnzADBGADGy3qPfj3vuaWCIzFy5ajncrXnekHNniyYVJt7Nf6kGISBu/DeGkZPUikmq/IgZkgKN1vMaLp1yHXXYT1f4yF5bbGMdBJcXnE02A5ZwrjOKN2Ibfqduqjq5G6g/yVUFzoD4t2lPYkZYuYbDXRzAsorNpR+Rm/YIOmTwraAorJ3SOhMt8dP6Yb2H6T5x+wf6U7nNzGWyszWA7oTUlwCQmeUdhIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqMglxcggqRF/NxCFEi+MVmLDRK4rLB8fY5yJjDfkQk=;
 b=hwf5zKHSs0wFzTlf+2R0XOVvVrZY33stUK9qmI1DcgwMCUIXg1Wy+qeY9UvNL4qs/7j1DEC3e9Gw6pPqGvQb6mrNgof6SmPOQpeMr8XOfiWj3nWh+DhQBgFa6CBZNJifxKtW4Y5gokJzQeXowIH2BhdL5NM+BdULrxLMGGOS/pU=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Wed, 16 Jun
 2021 06:01:16 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 06:01:16 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/pm: replaced snprintf usage in amdgpu_pm.c with
 sysfs_emit
Thread-Topic: [PATCH] amdgpu/pm: replaced snprintf usage in amdgpu_pm.c with
 sysfs_emit
Thread-Index: AQHXYmh9mNxVsCUmHU6IPu6ARXl+WasWJQvI
Date: Wed, 16 Jun 2021 06:01:16 +0000
Message-ID: <CO6PR12MB5473F951BC8F13E819172CFCA20F9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210616043100.2575-1-darren.powell@amd.com>
In-Reply-To: <20210616043100.2575-1-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-16T06:01:07.208Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [111.42.32.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47776373-d16c-4e4d-86b2-08d9308c27a5
x-ms-traffictypediagnostic: CO6PR12MB5475:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5475C21619C5494FF4C90E59A20F9@CO6PR12MB5475.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:106;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSp4V0ZqEwDUlqUEtKOg/dz/2DMp9JCC6/8DRIulJ7UKWR323QpMmdiwGj498GWlZHZ75VxH6wIZhglWredz37ZjIrX/Bi6AqGt0w+htFULKwW59wrYqbidpxvqRR5WusjLok1xawqJjw2uNjqqsFaKkSsT4Ko0lceY2kb0reUao3XaimzCuZ6GCXsYK8X0FkU5cFSU2WfIZzZizF5Vu5Iw8iUfb4YHUovXa822/wmlSKxsjbLZtlj66SzTfMlMxiN4VRfi+aLjcVZDAxb8tnx5J02vzlXk8aRFRc8YhheCnhvDtEgOJIO+FMFtNP4tJrPxvzB19dp+7ne3xUwvncomNZzEjvfy49Ej4eGRe2g2QusRfpkeefdphQ5wAypoDh8zvCU7ArdiZbJ9P5L7a8WPWF9dwEU0xshFPisloFvU0i0i/pu4Qs6La/RJhB73K38gLkpsZ1iGXyxPvHpxybMOE5crpErk09mhG40qf1fJVZ/ervF1t+XAdg1SD0PRIXLPWHADPzLXKeSAu5vj5ieMRHDCOHNvd6AYdHhvQTFgzrupCqZDBLbsnXO4tEjxwBD7BIjMp6lfxlnJZuLU8EAJ9rswXnll+C9yL5PEa3oOnLJNL7uY3bfUu3RBuB2pu0PFqDbxerSWrvTmr/paPVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(7696005)(86362001)(186003)(6506007)(76116006)(91956017)(26005)(52536014)(478600001)(8936002)(33656002)(8676002)(71200400001)(53546011)(110136005)(966005)(45080400002)(2906002)(122000001)(38100700002)(5660300002)(66476007)(83380400001)(9686003)(166002)(66946007)(19627405001)(66556008)(64756008)(316002)(66446008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bP/mUrPj2nVZc3pOo3IHDGR1abt0UeL2OAX5DeF13YjNbQiwbwNG+iJwmY?=
 =?iso-8859-1?Q?uX1zSXJFCwIM1U9LIUtDbjB5rGrNUDtg+mlE96cHxYDoVCwlWHlUKAnAwU?=
 =?iso-8859-1?Q?ET/zOj4pMxOd/WbY98CJjglHCo/pJhbiBmWVRust9QfSQzG7Rcrr1f88zH?=
 =?iso-8859-1?Q?tcNqrOC/6VLFqdiKAwg+3M6t7l7dzkG3swc15msXBPQiIGiPzohLuf4GWq?=
 =?iso-8859-1?Q?/hciVDhMsKfYC9NLPP0T5IR9SlwtWSemA3cxOguo42k2RtSNMrDs342/+j?=
 =?iso-8859-1?Q?5Wfq9gFBnalUzS9NH79G7wFvhEekeyJODd4xC4Y18JRNsZR8q4k4O3kd02?=
 =?iso-8859-1?Q?4ILZ/Onh5y/OKRgIU6QNujr/oo091aMPiFzR1acG9yykbkZnW5g1mhkfNa?=
 =?iso-8859-1?Q?TAPgvxKVVBhK0w6eU60VDw5yWV3qXqOhwzvfAZ11/dXNwnaKIkkHUFJ9ho?=
 =?iso-8859-1?Q?uyHZ5/GwlJ6P7cIv+4FttO+oFUci0500ZQsZ2IKxf792+zLQb64NgrZyyo?=
 =?iso-8859-1?Q?4LwxbvXeqHJLv7KzvE4MguYKdll4iOxdFiGWCRLg9zCp1Z1ZRm33Dh0in4?=
 =?iso-8859-1?Q?FhxppQPNTvHUB2nNTv01XeaZ+IrKI4v9HKFE7XQjHYMPfmMrcCIqi5dG8j?=
 =?iso-8859-1?Q?SlC5p/AYPuIgHSOwoHG1JdvxJCOUhnmBnSDbJj7NC2oLU4Y+e4t+90qkyJ?=
 =?iso-8859-1?Q?pfDVEncr4WB4PHRCevrVG7uLHRhOFXFXbLkK6hu/FdpTw92ESF+fq7ptDf?=
 =?iso-8859-1?Q?/3szzkAZhkZO7AMvKCQ8DyC2vNgmTr3eJaaz1v0OSgu+gOr6cnjSxDCUgX?=
 =?iso-8859-1?Q?XeZ5lwzSbfrq/w7japFcxD5AxjqVTSbYCsP3uWhuLoFc9XQ1i1HgJuxNdH?=
 =?iso-8859-1?Q?FLCz6JwWbTZqCfXJoyCLJC4CJarRoaHORW/iQCJco4GlzYH/chWW4lxywa?=
 =?iso-8859-1?Q?mTRewNsHbDdRrByPqmuBIgdQsMoYVLQE0RuGxVc039XA79M2a/klFICjyn?=
 =?iso-8859-1?Q?zDX7mM82Bsi+mIZlj+1VTVp0YY6L2V2Q/e/khh35Z01uraXDtvp3Mo4LKA?=
 =?iso-8859-1?Q?kFQhPxI+CdvDcr25gJ/JPJVe5Uk46cRlCriSIkygCKowgiXfrwn9TBQq2H?=
 =?iso-8859-1?Q?FKX23iBRy1FwRedZsTtQJWZvG31Ik2M48dC2ju2W51eEp46injJSKCr52K?=
 =?iso-8859-1?Q?Z4Wp/X98EB6Q2YEpk4zPLseKlG+lVldCA82AjBNPWQbwP5/jJ7NFm0YbOR?=
 =?iso-8859-1?Q?JGkE4bPkn5s4MwdbKOdwqbm3b4cGAb1dAAE4p7N4JlOP+ADWdW6Gbu0kA1?=
 =?iso-8859-1?Q?v+e2GmFNjNgj5ltDQ0LTrj59ZeMDfMsNK0xbEXWbxhTpjpw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47776373-d16c-4e4d-86b2-08d9308c27a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 06:01:16.7563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7I+nHs9U8n3yHGt+RwzxdoylMnuo8ErdsgYe14Wg2xQ3enZ6B3zWJt7sZSkjaqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
Content-Type: multipart/mixed; boundary="===============1862628833=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1862628833==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473F951BC8F13E819172CFCA20F9CO6PR12MB5473namp_"

--_000_CO6PR12MB5473F951BC8F13E819172CFCA20F9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Darren P=
owell <darren.powell@amd.com>
Sent: Wednesday, June 16, 2021 12:31 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH] amdgpu/pm: replaced snprintf usage in amdgpu_pm.c with sys=
fs_emit

replaced snprintf usage in amdgpu_pm.c with sysfs_emit
 fixed warning on comparing int with uint32_t in amdgpu_get_pp_num_states()

=3D=3D Test =3D=3D
AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " =
" -f 10`
HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}

lspci -nn | grep "VGA\|Display"  > scnprintf.test.log
FILES=3D"pp_num_states
pp_od_clk_voltage
pp_features
pp_dpm_sclk
pp_dpm_mclk
pp_dpm_socclk
pp_dpm_fclk
pp_dpm_vclk
pp_dpm_dclk
pp_dpm_dcefclk
pp_power_profile_mode "

for f in $FILES
do
  echo =3D=3D=3D $f =3D=3D=3D >> scnprintf.test.log
  cat $HWMON_DIR/device/$f >> scnprintf.test.log
done

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b2335a1d3f98..a276ebad47e6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -411,7 +411,8 @@ static ssize_t amdgpu_get_pp_num_states(struct device *=
dev,
         struct amdgpu_device *adev =3D drm_to_adev(ddev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         struct pp_states_info data;
-       int i, buf_len, ret;
+       uint32_t i;
+       int buf_len, ret;

         if (amdgpu_in_reset(adev))
                 return -EPERM;
@@ -433,9 +434,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *=
dev,
         pm_runtime_mark_last_busy(ddev->dev);
         pm_runtime_put_autosuspend(ddev->dev);

-       buf_len =3D snprintf(buf, PAGE_SIZE, "states: %d\n", data.nums);
+       buf_len =3D sysfs_emit(buf, "states: %d\n", data.nums);
         for (i =3D 0; i < data.nums; i++)
-               buf_len +=3D snprintf(buf + buf_len, PAGE_SIZE, "%d %s\n", =
i,
+               buf_len +=3D sysfs_emit_at(buf, buf_len, "%d %s\n", i,
                                 (data.states[i] =3D=3D POWER_STATE_TYPE_IN=
TERNAL_BOOT) ? "boot" :
                                 (data.states[i] =3D=3D POWER_STATE_TYPE_BA=
TTERY) ? "battery" :
                                 (data.states[i] =3D=3D POWER_STATE_TYPE_BA=
LANCED) ? "balanced" :
@@ -923,7 +924,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct devi=
ce *dev,
                 size +=3D amdgpu_dpm_print_clock_levels(adev, OD_RANGE, bu=
f+size);
                 size +=3D amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf=
+size);
         } else {
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
+               size =3D sysfs_emit(buf, "\n");
         }
         pm_runtime_mark_last_busy(ddev->dev);
         pm_runtime_put_autosuspend(ddev->dev);
@@ -1009,7 +1010,7 @@ static ssize_t amdgpu_get_pp_features(struct device *=
dev,
         if (adev->powerplay.pp_funcs->get_ppfeature_status)
                 size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);
         else
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
+               size =3D sysfs_emit(buf, "\n");

         pm_runtime_mark_last_busy(ddev->dev);
         pm_runtime_put_autosuspend(ddev->dev);
@@ -1070,7 +1071,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device =
*dev,
         if (adev->powerplay.pp_funcs->print_clock_levels)
                 size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
         else
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
+               size =3D sysfs_emit(buf, "\n");

         pm_runtime_mark_last_busy(ddev->dev);
         pm_runtime_put_autosuspend(ddev->dev);
@@ -1469,7 +1470,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struc=
t device *dev,
         if (adev->powerplay.pp_funcs->get_power_profile_mode)
                 size =3D amdgpu_dpm_get_power_profile_mode(adev, buf);
         else
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
+               size =3D sysfs_emit(buf, "\n");

         pm_runtime_mark_last_busy(ddev->dev);
         pm_runtime_put_autosuspend(ddev->dev);
@@ -2931,9 +2932,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,
                 r =3D -ENODATA;

         if (!r)
-               size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+               size =3D sysfs_emit(buf, "%u\n", limit * 1000000);
         else
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
+               size =3D sysfs_emit(buf, "\n");

         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -2971,9 +2972,9 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,
                 r =3D -ENODATA;

         if (!r)
-               size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+               size =3D sysfs_emit(buf, "%u\n", limit * 1000000);
         else
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
+               size =3D sysfs_emit(buf, "\n");

         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -3011,9 +3012,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,
                 r =3D -ENODATA;

         if (!r)
-               size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+               size =3D sysfs_emit(buf, "%u\n", limit * 1000000);
         else
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
+               size =3D sysfs_emit(buf, "\n");

         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7Ca4803946245b4521d26e08d9307f9e27%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637594146951324361%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DFg=
YkesFOLYQAfD2ZS6KFFO3soJm8Xutyv6nrJLivx%2Bw%3D&amp;reserved=3D0

--_000_CO6PR12MB5473F951BC8F13E819172CFCA20F9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Darren Powell &lt;darren.powe=
ll@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 16, 2021 12:31 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] amdgpu/pm: replaced snprintf usage in amdgpu_pm.c w=
ith sysfs_emit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">replaced snprintf usage in amdgpu_pm.c with sysfs_=
emit<br>
&nbsp;fixed warning on comparing int with uint32_t in amdgpu_get_pp_num_sta=
tes()<br>
<br>
=3D=3D Test =3D=3D<br>
AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | cut -d &quot=
; &quot; -f 1`<br>
AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d &q=
uot; &quot; -f 10`<br>
HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}<br>
<br>
lspci -nn | grep &quot;VGA\|Display&quot;&nbsp; &gt; scnprintf.test.log<br>
FILES=3D&quot;pp_num_states<br>
pp_od_clk_voltage<br>
pp_features<br>
pp_dpm_sclk<br>
pp_dpm_mclk<br>
pp_dpm_socclk<br>
pp_dpm_fclk<br>
pp_dpm_vclk<br>
pp_dpm_dclk<br>
pp_dpm_dcefclk<br>
pp_power_profile_mode &quot;<br>
<br>
for f in $FILES<br>
do<br>
&nbsp; echo =3D=3D=3D $f =3D=3D=3D &gt;&gt; scnprintf.test.log<br>
&nbsp; cat $HWMON_DIR/device/$f &gt;&gt; scnprintf.test.log<br>
done<br>
<br>
Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++-------------<b=
r>
&nbsp;1 file changed, 14 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index b2335a1d3f98..a276ebad47e6 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -411,7 +411,8 @@ static ssize_t amdgpu_get_pp_num_states(struct device *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_states_info data=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, buf_len, ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int buf_len, ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EPERM;<br>
@@ -433,9 +434,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(ddev-&gt;dev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_len =3D snprintf(buf, PAGE_SIZE, =
&quot;states: %d\n&quot;, data.nums);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_len =3D sysfs_emit(buf, &quot;sta=
tes: %d\n&quot;, data.nums);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; data.=
nums; i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; buf_len +=3D snprintf(buf + buf_len, PAGE_SIZE, &quot;%d %s\n&qu=
ot;, i,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; buf_len +=3D sysfs_emit_at(buf, buf_len, &quot;%d %s\n&quot;, i,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (data.states[i] =3D=3D POWER_STA=
TE_TYPE_INTERNAL_BOOT) ? &quot;boot&quot; :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (data.states[i] =3D=3D POWER_STA=
TE_TYPE_BATTERY) ? &quot;battery&quot; :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (data.states[i] =3D=3D POWER_STA=
TE_TYPE_BALANCED) ? &quot;balanced&quot; :<br>
@@ -923,7 +924,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct devi=
ce *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_dpm_print_clock_levels(adev, OD_RANG=
E, buf+size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_dpm_print_clock_levels(adev, OD_CCLK=
, buf+size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(ddev-&gt;dev);<br>
@@ -1009,7 +1010,7 @@ static ssize_t amdgpu_get_pp_features(struct device *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_=
funcs-&gt;get_ppfeature_status)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(ddev-&gt;dev);<br>
@@ -1070,7 +1071,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device =
*dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_=
funcs-&gt;print_clock_levels)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev, type, bu=
f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(ddev-&gt;dev);<br>
@@ -1469,7 +1470,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struc=
t device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_=
funcs-&gt;get_power_profile_mode)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_get_power_profile_mode(adev, buf)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
ddev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(ddev-&gt;dev);<br>
@@ -2931,9 +2932,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D -ENODATA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 1000=
000);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;%u\n&quot;, limit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(adev_to_drm(adev)-&gt;dev);<br>
@@ -2971,9 +2972,9 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D -ENODATA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 1000=
000);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;%u\n&quot;, limit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(adev_to_drm(adev)-&gt;dev);<br>
@@ -3011,9 +3012,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D -ENODATA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 1000=
000);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;%u\n&quot;, limit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(=
adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(adev_to_drm(adev)-&gt;dev);<br>
-- <br>
2.31.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Ca4803946245b4521d26e08d9307f9e27%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637594146951324361%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DFgYkesFOLYQAfD2ZS6KFFO3soJm8Xutyv6nrJLivx%2Bw%3D&amp;amp;r=
eserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D0=
4%7C01%7CKevin1.Wang%40amd.com%7Ca4803946245b4521d26e08d9307f9e27%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637594146951324361%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DFgYkesFOLYQAfD2ZS6KFFO3soJm8Xutyv6nrJLivx%2Bw%3D&amp;amp=
;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473F951BC8F13E819172CFCA20F9CO6PR12MB5473namp_--

--===============1862628833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1862628833==--
