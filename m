Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEE6C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 13:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2985206C0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 13:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NQX04Tl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2985206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651F06E266;
	Tue, 30 Jun 2020 13:31:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6376E266
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 13:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YezSMsXIyldhYBXHrtUdnZH4buq7T2sOSvya65Ax8+x/0OxmUu0BPRObVXGUO2Mj8c0uX3i5jIgc7yWh01hnG+hTfZOALUdeWiCaaAy3vZfyMI//yEp9ClX8vskZhq/AUm/rcX7P60YSNCwxYUzpSKtwZdw42ZIGGsuSiMHvlrI4O6lQgIFYDgyFqq6jiMaTPFPnQwaXeKXZu+qd+yJ9MaSHPHDmMc/yMLIv+daTn3uYBvVnYssnMEfvT2UZ+HoZQ8vCX+oQsfBOhb847aimJ5EyksJLqCt7IcbCUd5pjS0B60DZAQQw5txNG7hUTz4sIPv+uhLSGto0DXZHMz2jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+Ec5UjbMd9X1ixypy6OcRUIT7X/vfKydsv4bnZbleI=;
 b=kQm9VxZOeXhrb7B8zZD27XWGFvU7VHK5rdTeLSAsCsT37N3vZCfGNzvfaVtxz3LzJY/nlNkjVtwzoQQFc4JzgYyS+XI4ieBFWN4SB1rvnIy3xOwFj83qlQ10LFV1WOeEwS1EYSyrl/i7krS+vqeqTMVcDvdOztC8KCGwLFbnmAbNI82qPI4gXRwng0rKi3UZZbH1u0L5x2LSLOv+VF9rNeFb94LxX2l+EbsLLqJYzFqXA7hmuFNxL++sZBRXgr/nwGvvNUxTNmG85lo5i1jR82FJdDVnXlOdp3ZlkkH5CZWXNBvv99EG2edCdKHk9N565UlEjwSiX+Xa/3SWhq2QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+Ec5UjbMd9X1ixypy6OcRUIT7X/vfKydsv4bnZbleI=;
 b=NQX04Tl823do36IYf17iHCT/ZCdXgCM6gWVnEq5PjVzS6CCbt11pdbEXiDjhBlWEVXUSNT/h8f3o+n5hKjQaNv2YLHeVQSNxgDiFVCBuMcYV3kZZhRMGkzxQBd0e7lBlJ1hYnxw/hgoJNQsq0tb1wPO6Qrplqj8QRROnpvCQfos=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2681.namprd12.prod.outlook.com (2603:10b6:5:41::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 13:30:55 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 13:30:55 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Greathouse, Joseph"
 <Joseph.Greathouse@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
Thread-Topic: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
Thread-Index: AQHWToG3b3Yd6v+jHUi5syn3+OymV6jxDlBwgAAZq0A=
Date: Tue, 30 Jun 2020 13:30:55 +0000
Message-ID: <DM6PR12MB37218713D46441B0E396AD5D856F0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200630015526.197720-1-Joseph.Greathouse@amd.com>
 <DM6PR12MB3721BBE5C48881F357B90E8B856F0@DM6PR12MB3721.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3721BBE5C48881F357B90E8B856F0@DM6PR12MB3721.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-30T11:59:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=70894e1c-be0b-469e-9577-00003d1bc2c4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-30T13:30:54Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 130fac63-0193-45b9-b2ce-00008e8d3fc2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:70e8:89d3:2a74:6d44:185a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fa66664-4b53-4e25-fdcb-08d81cf9d141
x-ms-traffictypediagnostic: DM6PR12MB2681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2681F848104BA039DA8CCDE3856F0@DM6PR12MB2681.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3wmVRaff4ZVjiy2e5wQqM/MIOsBAAeGeO4OojeSi//0QDQyvn/BcB4oasMckmAEzFDboeYzye7XEv1cz4X+KQ/zTnrMkPSBuXLaXIajOiXKt87MiDcpehsOWY7h12afTpvagXuuMN2Mq+5DjEqQ6vLy0WXxHbuXyYcM7dZbVBbzxJYq8FgetOaYYvV0sv5I7z4UVbMqJc95d6GrWKQ95D8lt41vwVd+UvFZBWpL/cJQHHV0gt/Xg3kD0xK11eB9tWsV2VVN3F5JbEoutwTGVYk6j6MeoRLsoCN0Slobbl4I5LUa2ZtyIKDybfZ02OCbIUTSHAB+5E2Hi2YqHFWbxOp2t0Tv9nnsyW9NmUWofjpr3gCKOcr/gwgdMtRscpfHdznKL4CKwbWu5wSpn7sdKnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(9686003)(83380400001)(86362001)(83080400001)(66476007)(66556008)(66446008)(64756008)(66946007)(52536014)(5660300002)(33656002)(53546011)(55016002)(7696005)(186003)(478600001)(76116006)(8676002)(2940100002)(6506007)(8936002)(110136005)(316002)(2906002)(45080400002)(966005)(71200400001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: w+bKnS8+TJxIgi1wTFauvUfKWw1L5D3XF5+9/Xd60gZNZfmL0pW+hAq4fIWnlNt+/JbQEed/7Mot8/c8lPYutG4QATPwUG0Tt7bTg8VHKEd3K13n0QzlmU/Lcc7wtu2DLmi44feyKdP5Lrw3ANoqZe9Tm9JZCL5FNlXxbTYgggm/R2P2q4s5VQp7nXXv9Sp4W5z/tFxxEb25GG7yY3Ke8hTautAqrFdAhS7xWo/BzgfEPtBzUMEH4NWfUgGzu/agVyJicvjcYxp2k/BlDl57oTBPnp0GDcRsFzu9HjV62n5O5AZR0Me5ibOUQFRj0I1owxE2lIBd8tu2Id5DL5mq8Xw0HIdhQIe0juy20qSAa2cGEHarRsxSnly0ir/hEuFGbDWsj9KymtTutq4N2JQxSf/exgRNOOVtnOwfPjEp+ykxWnLbH9/aiQXlKmsWOVMmOCCaKdQc1dn8OgVcMqztTA/FVUxF0RAfx8HESHxDZDHAL5+XUgGpzmzhTix23sTohupiofBsftaBMfV2EfWy8JduNo3BC7GaTAMLfkF9eYBF0KPkkd3Ebi3fVES9Gmp5
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa66664-4b53-4e25-fdcb-08d81cf9d141
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 13:30:55.5582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fnrpiw8o9Kic1QoHSxPqOV7P+lHMTnuhHpHeiXVV16JUeMuoiSafFHKsNgNera8p9aRpJRqjfDc6HdFWWhDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
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
Cc: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks for answering my question offline. Patch is
Reviewed-by: Kent Russell <kent.russell@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Russell,
> Kent
> Sent: Tuesday, June 30, 2020 8:00 AM
> To: Greathouse, Joseph <Joseph.Greathouse@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
> 
> [AMD Public Use]
> 
> One inquiry inline
> 
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Joseph Greathouse
> > Sent: Monday, June 29, 2020 9:55 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>
> > Subject: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
> >
> > Add support for GWS in Arcturus, which needs MEC2 firmware #48 or above.
> > Fix the MEC2 version check for Vega 10 GWS support, since Vega 10
> > firmware adds 0x8000 to the actual firmware revision. We were
> > previously declaring support where it did not exist.
> >
> > Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
> > Change-Id: I9b44dfe59bdd8a38a0342e5155cdb071cf646cc5
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index 80393e0583bb..50886de3ba0a 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -602,9 +602,13 @@ static int kfd_gws_init(struct kfd_dev *kfd)
> >  		return 0;
> >
> >  	if (hws_gws_support
> > -		|| (kfd->device_info->asic_family >= CHIP_VEGA10
> > +		|| (kfd->device_info->asic_family == CHIP_VEGA10
> > +			&& kfd->mec2_fw_version >= 0x81b3)
> > +		|| (kfd->device_info->asic_family >= CHIP_VEGA12
> >  			&& kfd->device_info->asic_family <= CHIP_RAVEN
> > -			&& kfd->mec2_fw_version >= 0x1b3))
> > +			&& kfd->mec2_fw_version >= 0x1b3)
> [KR] Is it 0x1b3 for both VG12 and RV? I wasn't sure if it was 0x1b4 for VG12, or
> did they just update the FW again and I missed the original?
> > +		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
> > +			&& kfd->mec2_fw_version >= 0x30))
> >  		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
> >  				amdgpu_amdkfd_get_num_gws(kfd->kgd),
> > &kfd->gws);
> >
> > --
> > 2.20.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.fr
> > eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C763e1f08fe29488bf1
> >
> 6c08d81c98b2c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> >
> 7290790080559728&amp;sdata=22Hd8tIxsjF%2BLXiBKQgSt6EbOTIHqifVSYMb
> > W1AWxV4%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7Ca4e3323d9bcc417be
> 40808d81ced2013%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37291152507197101&amp;sdata=zrfmEq3xf5Y2MoFGnBK8EP5eYqZmWXPm3y
> KlrEtcMdU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
