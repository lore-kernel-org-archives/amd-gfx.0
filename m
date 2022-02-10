Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9CAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 15:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9A510E1A4;
	Thu, 10 Feb 2022 15:07:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1596510E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 15:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjbjwrN+nybjXclzBRzVuj1KpL/uShCR1NSLBfPqZ+byq9R+6PD4tN8S0/llYo/wZ8BPSdGeJai2H7bnDgn9c28RdV2aXAkgLv5hJY2wTDzLnLs+C2KRk+nQZPx6YWmUL7TwcIh+SydQRPsWLusPrUna0FoHFG6OuRwjwHK3M5jptX826aZftDSpq+4C5CLwFu2Ka/pyCVST+OuSTEcKiz5c4EvDoFiijzAkMO7PLGBxuAp50s12VyCPe0XxX+TAHLVyXAS5UnuI+rH9w/NFqRQUWL5TH5LFFjS/eykvj5OcRpVjSUIsVwvo0G5Kg0sqZgZdi1PDdiirhAqfk96XzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjBD3oxktlzlM681ysilD4pu8LrXC2uMD0SUl5qsvtM=;
 b=FCIKHIV2z98Q6MFJT1ignwilT8eCs7vNRUVBXjpDFlyuMZkzhZW03UlJ2E7iZx2NfH1MsTNkGvxLE+Cal4BBs09YnaXwXBHNsQm4WMJFoJeai9YiJG+Fj0x/hzMJq1M2+evzsYeG0qzTKU1ptPTn4M205qC91Ol/1EP0ca2qqS7KhBZscwzbMawudWYhNvZCO++iVpo8hoX9N8MDYTX1GRKRPG9VVJS45hgyoYvOTTFfz09CGEgMCY2aHi4jxdVPI5oFVDnaKzvW8/ytkc4TX8xmp/znGJqbMuM233nGXslyAtJGuH8N3lcvNSHamom+kf7mQman7QKFCmBn2JFplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjBD3oxktlzlM681ysilD4pu8LrXC2uMD0SUl5qsvtM=;
 b=cRI2cbSOJ3yfm2uLVwfGkBDl/ThRRXgCiZdMiby5arYLtPZymwm4gM5ZLSE+8tTGnI+QhWy91v2XqKnG1l7IixWC2nJpgpAvVmhsUUNE18tV0my1k1Nmj11u0/S1uDl53hOhO/wAX6T1tLwLzu5cThMm0I9YnvyGkfI+nZsEMCY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 15:06:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 15:06:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Thread-Topic: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Thread-Index: AQHYHkknOB4ytTD+ZEmhxSttxV1MuqyM4q+9
Date: Thu, 10 Feb 2022 15:06:55 +0000
Message-ID: <BL1PR12MB51445CC3CEDC76CFAD642D71F72F9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220210064029.16545-1-guchun.chen@amd.com>
In-Reply-To: <20220210064029.16545-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-10T15:06:54.965Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 168378c8-2587-7c58-0240-1fe5211df521
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a02c0834-aa64-4f90-4adc-08d9eca6fa60
x-ms-traffictypediagnostic: DM4PR12MB5149:EE_
x-microsoft-antispam-prvs: <DM4PR12MB5149F9A2AA5FA925FA02A273F72F9@DM4PR12MB5149.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Clw1JFBRtVO5UrniuBI9kKAUzGWa3uY6iUzO/niWJEsLCn8SVr+8oej5fwv744NoCHHxQIR3vc9CAYfXOs7+2DP5CXAFIXPurIKbM8QK51qZn08Cl8snw7YvDBCHIVfSq33L44k6+B2za31UOVlGnjGGBw3QYMb54s2NLdNRRFVFUH/8KDZs1F8K2Z6+sTm0g89vlWLwVaTYk7y3+YWuLGM10PCNwGbZ4YvjmWK21swJp3N/PAFqEZdSs0VzmFj+u9H+QvrfhUvkjariP1PuPe3nsUdcaecNRLFNrSzIsmYW7klRcxxcJJ68SgJ8T4KJMMCpNUX7l1W6QeKFu+btwCEkSxV5XaeUkpEoIQ2CWQ77Lklm3EModVhqRJqJgURRemzI3N2KpyCFcBdCinzurhF730CpWaeABwsilJax5IP0a+YLuHBWbbOcfD72+S4Ecz22HE4ia4Y9Mbo9f3il7BDO/BsaoNHJQP8Fj5ph1vAtEpADsWM9Zg5BA3v+RssQ1iZg6cnk5paLRHe6GE4rZjZl4nm9nsraiOgOpB12K0PRFswB2G8NsLXPaJNi2M7HB/Ym0x92TmgfodAx0hG/Wl+yekmRH3+blokXayMRVqbMQfpjJxtH73qoDstXLLFGBGRldVSkVS3eBj24bAFZ6TRr8yAA05tOgCcKJg/oebx7fDlpnx7+eVTFFgLBopfs7wYur/3ifjXR6QfF5QXHxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(38070700005)(26005)(186003)(6636002)(38100700002)(122000001)(52536014)(110136005)(9686003)(66446008)(5660300002)(19627405001)(316002)(53546011)(76116006)(66556008)(64756008)(508600001)(33656002)(86362001)(55016003)(71200400001)(8936002)(8676002)(66476007)(6506007)(7696005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ne451/WjmN6S1DRUC6Mg1yOMdZUuorL5uHSuDl4+p0eg1C0m+2qZdXK5tDF+?=
 =?us-ascii?Q?MPRgMl7KYUdrZ5CeqiD1lLBOjY8dt+KBTRKWdI1RC9Rl6HOwJ26NT/Yr6mP8?=
 =?us-ascii?Q?BlpkXtzwPDw5naBTW/J1S1wVrDYB6DJxFqkAuHDirCcCvs9Z5ISZK/n5A1gF?=
 =?us-ascii?Q?xEYsMbhrkiXc17r0QnjRwNVr0dzRzIDDdxXD0M/JsIG+u/FWIaqPY3dvQuiV?=
 =?us-ascii?Q?pWfu++lLWobpDHG2dxdRraLS6IG9S0sV8jmA4lkGzuosgs9RvxjRcdZPrvBv?=
 =?us-ascii?Q?b9A/2xY92kVJEadHZIfn+WWUP3/oQj9cAV1erOCNKgmzxXBhtlqC+xfmxJur?=
 =?us-ascii?Q?l45EVlOkwWP8kwZpZZpIYOt/b4c1luvS87gTWJiYM1WFmbnzo5A5zJk50i8L?=
 =?us-ascii?Q?Kr2ZLDa5Hdtj0lLokZdFywy1TSpvjdv7mWIwv9skUXxZUB/DGBQJSNtabYZC?=
 =?us-ascii?Q?Wfc31YVUWKRttbU5IyMPZaTvxETRwqyRxK/D/lbKAquOqTD0vxy5br1/eRtv?=
 =?us-ascii?Q?TRd2V1uLHVdJ+jakRUy6M19YiXMY4X6tPKC/MxxEo/vZ5vt3VcUsAecjj70K?=
 =?us-ascii?Q?lBRp8KTqyFMGPo5U+VvvjXxS8IohW6wD8LvIXJmNOjAEU/ZJ+FfS3FeBUfuP?=
 =?us-ascii?Q?1VkY8qoIiDRCTbR6RVVdNZsI4WcmSmezfTohshln1ZnZ2bewUcwRwnxKfNR5?=
 =?us-ascii?Q?4+iALIo4ZyUbc5fOw679RIZGNyxvz2KhH4ZGJtABylYDI5x7mKsker7AgAka?=
 =?us-ascii?Q?nggLGGUndpeb8A495jcZIKBpLdUfbx5PxWjJKxuA9/3dr+OfX+pDed8VWfie?=
 =?us-ascii?Q?6tcjI46hMmnN4MyaSV44Lb+MlHH7d1rZDjY6VGcfuEUAu3touOMJ1Ph/J5X0?=
 =?us-ascii?Q?xxPa44DBb0KEdomNE5ctVqY62bYFDrQnqGgEhUXE7C7Q8W2tAr+UCpEqZ9Kx?=
 =?us-ascii?Q?32qejgfR4vNpt/SB8At76TKPVtobRLlz1vCgbzUcuwfc9LtSB9gAulqTVr5H?=
 =?us-ascii?Q?xYyTQzCv7hpyDGt9jmYLaOOt89IdT2OHPSDPg3tYhMnKom29loVvRvipW6v7?=
 =?us-ascii?Q?docQ1BAXoxCElPP6BjCbh+k9mzic4y4xD4endnuUGeAikBc5kV2juRpJs/qg?=
 =?us-ascii?Q?kREXnFEHFno0VnTuOAdLvcBjgVGVkHn4SfLHrePr4E8I+bhbEIeZTnqjqmnd?=
 =?us-ascii?Q?UJTqqkLgYPfC/4im9t6tJUYtdE9dFZdSgMyc0EENxSw3SBsUf7ZJjNbUi/9t?=
 =?us-ascii?Q?0sZbLsEPaZcMi3vCqHy7zCf3HuguQsEZNzExXcVsR9NgI7K8DpwZ7f+UcJqu?=
 =?us-ascii?Q?VZxDCu96cSh8S+FCYvfooELGobnRfS3/GrcgDjaqtiflObEom7XhOlfkfhWr?=
 =?us-ascii?Q?b44bJc6EMP1hawxcGJnuxtuCOP0RWd9o3UxsBBNPLT0bovedI7XFP7sAzsbf?=
 =?us-ascii?Q?kUvuVNvelyc7hXKjSEHvCFO3U3/87N0J/ibB8H6KK73jC+QCJuABIy8UPcZs?=
 =?us-ascii?Q?E3ahLIh7Um7emjPlWqpcMfR7seX9G+B6Mgrh+NkdxE2+dUeM8R9WXSBR+hVr?=
 =?us-ascii?Q?TIQ9/crPAFCyG1ktnuak6g23LbopCYhLolc1VX+WasceKgsbQfXcGNngDp8I?=
 =?us-ascii?Q?erlpX5jzr4LTo2u233GRQiQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445CC3CEDC76CFAD642D71F72F9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02c0834-aa64-4f90-4adc-08d9eca6fa60
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 15:06:55.7268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qw7Kvk0SyGXrjN5YyT+22CqJ2iNWIRL5Ak126bP0n55WtjjHRWL36nU+kXnokzrTA3Qqf6BwaZFtMXbNWaDKFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
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

--_000_BL1PR12MB51445CC3CEDC76CFAD642D71F72F9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

For better future proofing maybe adjust the check to look for pre-gfx10 rat=
her than checking for specific IP versions?  E.g.,

adev->ip_versions[MP0_HWIP][0] < IP_VERSION(10, 0, 0)
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, February 10, 2022 1:40 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Koenig=
, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9

Fall back to MMIO to read registers as rlcg read is not
available for gfx v9 in SRIOV configration. Otherwise,
gmc_v9_0_flush_gpu_tlb will always complain timeout and
finally breaks driver load.

Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx=
9")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..a3274fa1c7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -37,6 +37,16 @@
                 vf2pf_info->ucode_info[ucode].version =3D ver; \
         } while (0)

+static bool amdgpu_virt_is_rlcg_read_supported(struct amdgpu_device *adev)
+{
+       /* rlcg read is not support in SRIOV with gfx v9 */
+       if ((adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(9, 0, 0)) ||
+               (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1)))
+               return false;
+
+       return true;
+}
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
         /* By now all MMIO pages except mailbox are blocked */
@@ -957,7 +967,8 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
         u32 rlcg_flag;

         if (!amdgpu_sriov_runtime(adev) &&
-           amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, fal=
se, &rlcg_flag))
+               amdgpu_virt_is_rlcg_read_supported(adev) &&
+               amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 false, &rlcg_flag))
                 return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag)=
;

         if (acc_flags & AMDGPU_REGS_NO_KIQ)
--
2.17.1


--_000_BL1PR12MB51445CC3CEDC76CFAD642D71F72F9BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
For better future proofing maybe adjust the check to look for pre-gfx10 rat=
her than checking for specific IP versions?&nbsp; E.g.,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">adev-&gt;ip_versions[MP0_HW=
IP][0] &lt; IP_VERSION(10, 0, 0)</span></font><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 10, 2022 1:40 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou, Peng Ju &lt;PengJu=
.Zhou@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deuc=
her, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for g=
fx v9</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fall back to MMIO to read registers as rlcg read i=
s not<br>
available for gfx v9 in SRIOV configration. Otherwise,<br>
gmc_v9_0_flush_gpu_tlb will always complain timeout and<br>
finally breaks driver load.<br>
<br>
Fixes: 0dc4a7e75581(&quot;drm/amdgpu: switch to get_rlcg_reg_access_flag fo=
r gfx9&quot;)<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 ++++++++++++-<br>
&nbsp;1 file changed, 12 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index e1288901beb6..a3274fa1c7e4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -37,6 +37,16 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vf2pf_info-&gt;ucode_info[ucode].version =3D ver; \<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (0)<br>
&nbsp;<br>
+static bool amdgpu_virt_is_rlcg_read_supported(struct amdgpu_device *adev)=
<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rlcg read is not support in SRIOV =
with gfx v9 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[MP0_HWIP][0=
] =3D=3D IP_VERSION(9, 0, 0)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1)))<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+}<br>
+<br>
&nbsp;bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* By now all MMIO pages e=
xcept mailbox are blocked */<br>
@@ -957,7 +967,8 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rlcg_flag;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_runtime(=
adev) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_g=
et_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &amp;rlcg_flag))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_virt_is_rlcg_read_supported(adev) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, fals=
e, &amp;rlcg_flag))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_=
flag);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acc_flags &amp; AMDGPU=
_REGS_NO_KIQ)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445CC3CEDC76CFAD642D71F72F9BL1PR12MB5144namp_--
