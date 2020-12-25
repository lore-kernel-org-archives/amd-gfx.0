Return-Path: <SRS0=eRNB=F5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1613C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 06:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D4823129
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 06:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D4823129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F8F989B18;
	Fri, 25 Dec 2020 06:34:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5730A89B18
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Dec 2020 06:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W93RIXSZYlVv1c8neLHmz4khD4Ku6ChtWcT8lR08pdXP9e3L+J0rLCj3MZqY5VhseU23Ee5hvC+jIwDZePtgzD1dMkD83dUFMHw20+yiCRpKdh8WGL4fPBRMBywlgJGLzWdzzh4UPqe8TM9a35Qcte0g6OC84n9uArSFG7EH2jWb66J6PRcmoYwifgl8pj76bBp7L+BvRmIBUI8QSnOn0ChQLfzjlHo1ls6v2/M3DhukewLS7cpglAWtjPJ62uauk8g/ipunFLwn83ZUxAFOOKTlz6Es2SGvqylA7Bes/pPUPasqHicnr4zktDy41PkoEmoy0hc4KI9Bb/pYor0B8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8wE5XX14QdMUhMOCiYJ9sFygrMunCBOHI1eTTbDNIE=;
 b=cLGYiZWsj0O5HwxnpO272v2s2bAXqlS4pmghYLxgjCTCpGVS3FR3AsU+NSV6/sCU3eXbrRK40Z9/IfdxPbdFrvid6DTmabyovrcxAXSSZjDzgjV33tIrQN07G+30MTE+GCqN4nfe+NcZQBhTPt96MSPXL5oDe9zNJsUxtIqEAluT0SKJE7cIMiRK4zrM5aX8+GFc0iYFa/FUUOGVzEfIP+94HWdCnZtdedM1vjbGCREd/GMWWddmm1n51d6y7dizWOBZWHUezvy4GVmCj6UKKWUu5raIMQCJjW//5w40MD/0IvqQeR4kn0i5NJtZ+bjGLQRa0xiidMheomRVUHiFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8wE5XX14QdMUhMOCiYJ9sFygrMunCBOHI1eTTbDNIE=;
 b=Qyypgzf8ez1Nf9FNzmck9jUbU5CU/WPifa7AQnEY/B5lsOd/WRE+a2xl2ycKg4RkwsMYQz4x9hv8uIgunkW9b+MwS/CwAkg+nDyMNlDDpgopNus3KjvMsMqk6TtjIvmpewBWA3RYWvK//k5uMxq98jP7ZGdOqx6oYxuaYS2/Zm0=
Received: from DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23)
 by DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Fri, 25 Dec
 2020 06:34:18 +0000
Received: from DM6PR12MB4371.namprd12.prod.outlook.com
 ([fe80::19b9:e4e6:c55e:29a8]) by DM6PR12MB4371.namprd12.prod.outlook.com
 ([fe80::19b9:e4e6:c55e:29a8%5]) with mapi id 15.20.3700.026; Fri, 25 Dec 2020
 06:34:18 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
Thread-Topic: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
Thread-Index: AQHW2bqz4CwQrLh3LEK7B0BSA355aKoG2SCAgABJvAA=
Date: Fri, 25 Dec 2020 06:34:17 +0000
Message-ID: <DM6PR12MB4371898E35F11AA52AE238DBF8DC0@DM6PR12MB4371.namprd12.prod.outlook.com>
References: <20201224060434.18144-1-PengJu.Zhou@amd.com>
 <d35f603a-dbbe-fba4-c1c5-79b4f00e3ccd@molgen.mpg.de>
In-Reply-To: <d35f603a-dbbe-fba4-c1c5-79b4f00e3ccd@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-25T06:33:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e79ca643-b97f-4ffb-82c8-000021c0ecdd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-25T06:33:57Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 63618689-9cb2-4a65-be9e-00003c39656e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: upstream
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 658b2edd-e39d-4eba-afc1-08d8a89f1b26
x-ms-traffictypediagnostic: DM6PR12MB3753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37531E6B61E876CDBDA72F8DF8DC0@DM6PR12MB3753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2IUWFMaxHUruXpx4TbeotwjzKJz+9ctfxd0Emie2pCrj2JVwki7vZT816qAEMMbHp9OgJ/V8fHyKWZj1cHISVAf/Wwt0ZfwCWew/Y8WwiNGWG0ZEzRZ8TBolRf+co6iMhTns6LLKjtfxftb70NRMbpRQoJ70HrR118b7Ne1kYTrWgxMG6UWH75pbgSNDgWrg9Z7wYHAVBY1og2v1jHiTlLrrfzzFM/IR2XKgLPJ1xe+Qq/1gruBmR882z63zzJqW/iJU/9r+awHTeSUDuSZ4BdYvdTnkFO+BRnfhhnttF5+mtsv0VNnyupZmNajltFpb8Eg5GsQ1Iu8xsvUVoy/4z0fB8PFEO/EECnr/K2VGPwFg0YcG71npllEo6omRK7/mR6OewhI6olQW6CBd+Mqnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4371.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(76116006)(66946007)(86362001)(9686003)(26005)(7696005)(2906002)(54906003)(6506007)(8676002)(66476007)(186003)(55016002)(66446008)(316002)(64756008)(66556008)(71200400001)(33656002)(4326008)(52536014)(53546011)(5660300002)(6916009)(83380400001)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-7?Q?T5plUm/DwLMKHiTrGELHD6+JGixPYkWUsCYRqesi+egg/lDCuWXoq0UOLp?=
 =?iso-8859-7?Q?XC99Zn6cabq4bCgKkOyLO1qnQoiuItx57+87seXiRLEtNfay1+CU7nHNsp?=
 =?iso-8859-7?Q?b35QnFxxLyjKhr0YBFmGog8UqCiu77RViJdBXb86vk6RkX0S2pKKSRqTGt?=
 =?iso-8859-7?Q?J2Yt2a+BqAy1qkI0AglKSuqCV1xiG5G0uzfhTp/kZB+SPFYUCLlS8xrvV+?=
 =?iso-8859-7?Q?uvQgUbrnpeUvBawopfV6YQsnLQyLx1oBEBHDVVEFeM3NJWkaWiCVOoE03B?=
 =?iso-8859-7?Q?B2DZelog43995WoemXMcQX73QAr0u151xahaCoIW7Vrb8S5ydt7iEPGdxj?=
 =?iso-8859-7?Q?J3vF2g85UooUlYlTzF3qCxq9Q30dr4VoNZUg+8jPrk5PYzj1fPASUNvVht?=
 =?iso-8859-7?Q?foi01U5BmbBzZR4XRIQa3EPs7M1VP1DOuJP8SD0iGirR91RqIofTsu88Y9?=
 =?iso-8859-7?Q?12mo1SU0s03PY031ECkIBQdBx/jB8Hr9CMXw/BS8vzzHu+wN/O6pZO03A+?=
 =?iso-8859-7?Q?L5lkdrgb7RGeGpCPAZiXQw92EbiMiZuWW42xnAo5doQBFbEzAtQRQD+wh2?=
 =?iso-8859-7?Q?yMFo3Y8shoz2NATy8JyQ/Aj86ycWeWNsiNny0nZFOOMqmGP5WWPDXOmBfH?=
 =?iso-8859-7?Q?u5oYPy9yP4XZ/ltvIAGXjIFDc7azt5lg0a9hJw7DvkBkN3GmwJjbnY+OQB?=
 =?iso-8859-7?Q?BqlkfrdM636sCjNdkHeY0Y1uX2k+Y3ce+NUgc81U6nd9YsXHXUgN1lzl+f?=
 =?iso-8859-7?Q?iVMCl/vPESgEUooncNrqhsnIaRQMakeSJkFubqa2EgFLu2zAYZg5iCtboM?=
 =?iso-8859-7?Q?KtyvJffDnGiaFnPpWLspInCBmMsxlUOS1JgPBk5rTHsmATgnQLGUoRi38C?=
 =?iso-8859-7?Q?1UUUhco2EP+vvRAO7tuDDKmbXofe231YWIYkgEzjVeG3GBbWKZM68/iOyn?=
 =?iso-8859-7?Q?Nl/ncbWLQTIbiWHg5xbg1NfB+FgiLm5K1KQnIednTji6ixFtkZjFc0rAbU?=
 =?iso-8859-7?Q?ZvhMKWC7P+yG8SSFY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658b2edd-e39d-4eba-afc1-08d8a89f1b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 06:34:18.0317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AN/rcpzIReOEBtiOmq6YftyFE6TldsMTT/DTR4PUL8PiUeXJ7VCOXnWw6y8i8DYRRjSqgqGbvL8TRTljBb9s9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1094381649=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1094381649==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4371898E35F11AA52AE238DBF8DC0DM6PR12MB4371namp_"

--_000_DM6PR12MB4371898E35F11AA52AE238DBF8DC0DM6PR12MB4371namp_
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


Hi Paul

  1.  The 50 ms is the whole full access time reduced, not one msleep(1),

During amdgpu driver init, it will hit msleep(1) several times which increa=
sed the total time of full access.



I load amdgpu in the guest VM and collect VF's full access time in the host=
, host dmesg  was listed in the below:
In this time, the time reduced : 0.236847 s - 0.150411 s =3D 86.436 ms .
(The reason why it is 80+ms is that I add some code to program one register=
 by psp. )

VF Start Full access
VF exit full access
VF full access time
msleep(1)
295.9031 s
296.0535 s
0.150411 s
usleep_range(10, 100)
658.1791 s
658.4159 s
0.236847 s



  1.  If I only change msleep(1) to usleep_range(10, 100),  the polling tim=
e will reduced from 2 seconds to 0.2 seconds,

So I change timeout from "timeout =3D 2000;" to "timeout =3D 20000;"



host dmesg  with udelay_range(10, 100) in amdgpu:

[  295.903102] gim info libgv: [4:0:0][amdgv_sched_enter_full_access:877] V=
F0 entered full access mode.

[  295.906661] gim info libgv: [4:0:0][amdgv_ih_iv_ring_entry_process:254] =
PF_VF_MSGBUF_ACK received

[  296.052903] gim info libgv: [4:0:0][amdgv_ih_iv_ring_entry_process:192] =
VF_PF_MSGBUF_VALID received

[  296.052910] gim info libgv: [4:0:0][amdgv_ih_iv_ring_entry_process:205] =
Received Event: VF0, event =3D 0x2

[  296.052914] gim info libgv: [4:0:0][amdgv_sched_event_queue_push_ex:193]=
 queue event REL_GPU_INIT(0xef01) for VF0 of block(0xf0)

[  296.052934] gim info libgv: [4:0:0][amdgv_sched_process_event:1582] proc=
ess event REL_GPU_INIT (0xef01) for VF0 of block (0xf0)

[  296.052944] gim info libgv: [4:0:0][navi12_gpuiov_set_mmsch_vfgate:904] =
mmsch mb ints disabled schedid =3D 4

[  296.053334] gim info libgv: [4:0:0][navi12_psp_v11_set_mb_int:632] psp m=
ailbox disabled for VF0

[  296.053513] gim info libgv: [4:0:0][amdgv_sched_exit_full_access:976] VF=
0 exited full access.



Host demsg with msleep(1) in amdgpu:

[  658.179053] gim info libgv: [4:0:0][amdgv_sched_enter_full_access:877] V=
F0 entered full access mode.

[  658.182648] gim info libgv: [4:0:0][amdgv_ih_iv_ring_entry_process:254] =
PF_VF_MSGBUF_ACK received

[  658.415227] gim info libgv: [4:0:0][amdgv_ih_iv_ring_entry_process:192] =
VF_PF_MSGBUF_VALID received

[  658.415237] gim info libgv: [4:0:0][amdgv_ih_iv_ring_entry_process:205] =
Received Event: VF0, event =3D 0x2

[  658.415241] gim info libgv: [4:0:0][amdgv_sched_event_queue_push_ex:193]=
 queue event REL_GPU_INIT(0xef01) for VF0 of block(0xf0)

[  658.415299] gim info libgv: [4:0:0][amdgv_sched_process_event:1582] proc=
ess event REL_GPU_INIT (0xef01) for VF0 of block (0xf0)

[  658.415311] gim info libgv: [4:0:0][navi12_gpuiov_set_mmsch_vfgate:904] =
mmsch mb ints disabled schedid =3D 4

[  658.415719] gim info libgv: [4:0:0][navi12_psp_v11_set_mb_int:632] psp m=
ailbox disabled for VF0

[  658.415900] gim info libgv: [4:0:0][amdgv_sched_exit_full_access:976] VF=
0 exited full access.





----------------------------------------------------------------------
BW
Pengju Zhou




-----Original Message-----

From: Paul Menzel <pmenzel@molgen.mpg.de<mailto:pmenzel@molgen.mpg.de>>

Sent: Friday, December 25, 2020 6:44 AM

To: Zhou, Peng Ju <PengJu.Zhou@amd.com<mailto:PengJu.Zhou@amd.com>>

Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; De=
ucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.co=
m>>; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@am=
d.com>>

Subject: Re: [PATCH] drm/amdgpu: reduce the full access time by about 50ms



Dear Peng Ju,





Thank you for your patch.



Am 24.12.20 um 07:04 schrieb pengzhou:



Could you please configure your name in git:



     git config --global user.name "Peng Zhou" # or Peng Ju Zhou



Also, please mention PSP in some way in the git commit message summary.

Maybe:



> drm/amdgpu: Reduce delay in PSP command submit by ...



> The function msleep(1) can be delay to 10+ ms sometimes, which

> contributes a big delay during the full access time.



Do you have the Linux log messages with timestamps, where the delay can be =
seen?



> Changing msleep(1) to usleep_range(10, 100) and it can reduce about

> 50ms delay during full access time.



(Please wrap lines after 75 characters.)



`usleep_range(10, 100)` is 100 =ECs which is less then 1 ms (=3D 1.000 =ECs=
).

What datasheet specifies the needed delays?



> Signed-off-by: pengzhou <PengJu.Zhou@amd.com<mailto:PengJu.Zhou@amd.com>>

> Change-Id: I151a07c55068d5c429553ef0e6668f024c0c0f3d

> ---

>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-

>   1 file changed, 1 insertion(+), 1 deletion(-)

>

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

> index 523d22db094b..ef69051681cf 100644

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

> @@ -282,7 +282,7 @@ psp_cmd_submit_buf(struct psp_context *psp,

>                           ras_intr =3D amdgpu_ras_intr_triggered();

>                           if (ras_intr)

>                                         break;

> -                        msleep(1);

> +                       usleep_range(10, 100);



With `timeout =3D 2000`, this was a maximum of two seconds (or even 20 seco=
nds judging from your commit message). With your change it seems the waitin=
g time is reduced to 0.2 seconds.



I do not understand, how you reach 50 ms in the commit message title?

Only if the msleep would take 50 ms, which is unlikely.



>                           amdgpu_asic_invalidate_hdp(psp->adev, NULL);

>            }



It's great to see these kind of optimizations, as amdgpu takes 400 ms to lo=
ad on my system.



In a followup the logging should be improved too. Maybe, print a warning, s=
hould it take longer than five milliseconds.



I tested that it still boots on my MSI B350M MORTAR (MS-7A37) with AMD Ryze=
n 3 2200G, but couldn't determine if the patch improved the boot time in an=
yway due to absent logging.





Kind regards,



Paul

--_000_DM6PR12MB4371898E35F11AA52AE238DBF8DC0DM6PR12MB4371namp_
Content-Type: text/html; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
7">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:942803006;
	mso-list-type:hybrid;
	mso-list-template-ids:-1574110382 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1540163180;
	mso-list-type:hybrid;
	mso-list-template-ids:1221723824 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheadera92f4c5c" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:11.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi Paul<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoPlainText" style=3D"mso-list:l1 level1 lfo2">The 50 ms is t=
he whole full access time reduced, not one msleep(1),
<o:p></o:p></li></ol>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">During amdgpu driver i=
nit, it will hit msleep(1) several times which increased the total time of =
full access.
<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">I load amdgpu in the g=
uest VM and collect VF&#8217;s full access time in the host, host dmesg &nb=
sp;was listed in the below:<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">In this time, the time re=
duced : <span style=3D"color:black">
0.236847 s</span><span style=3D"color:black"> - </span><span style=3D"color=
:black">0.150411 s</span><span style=3D"color:black"> =3D
</span><span style=3D"color:black;background:yellow;mso-highlight:yellow">8=
6.436 ms</span><span style=3D"color:black"> .<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in"><span style=3D"color:blac=
k">(The reason why it is 80+ms is that I add some code to program one regis=
ter by psp. )<o:p></o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"562" style=3D"width:421.5pt;margin-left:41.75pt;border-coll=
apse:collapse;border:none">
<tbody>
<tr style=3D"height:14.5pt">
<td width=3D"150" valign=3D"top" style=3D"width:112.2pt;border:solid window=
text 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black"><o:p>&nbsp;</o:p></span></p>
</td>
<td width=3D"130" nowrap=3D"" valign=3D"bottom" style=3D"width:97.8pt;borde=
r:solid windowtext 1.0pt;border-left:none;padding:0in 5.4pt 0in 5.4pt;heigh=
t:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">VF Start Full access<o:p></o:p></span></p>
</td>
<td width=3D"126" nowrap=3D"" valign=3D"bottom" style=3D"width:94.5pt;borde=
r:solid windowtext 1.0pt;border-left:none;padding:0in 5.4pt 0in 5.4pt;heigh=
t:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">VF exit full access<o:p></o:p></span></p>
</td>
<td width=3D"156" nowrap=3D"" valign=3D"bottom" style=3D"width:117.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;padding:0in 5.4pt 0in 5.4pt;heig=
ht:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">VF full access time<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:14.5pt">
<td width=3D"150" valign=3D"top" style=3D"width:112.2pt;border:solid window=
text 1.0pt;border-top:none;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">msleep(1)<o:p></o:p></span></p>
</td>
<td width=3D"130" nowrap=3D"" valign=3D"bottom" style=3D"width:97.8pt;borde=
r-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-rig=
ht:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">295.9031 s<o:p></o:p></span></p>
</td>
<td width=3D"126" nowrap=3D"" valign=3D"bottom" style=3D"width:94.5pt;borde=
r-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-rig=
ht:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">296.0535 s<o:p></o:p></span></p>
</td>
<td width=3D"156" nowrap=3D"" valign=3D"bottom" style=3D"width:117.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">0.150411 s<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:14.5pt">
<td width=3D"150" valign=3D"top" style=3D"width:112.2pt;border:solid window=
text 1.0pt;border-top:none;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">usleep_=
range(10, 100)<span style=3D"color:black"><o:p></o:p></span></p>
</td>
<td width=3D"130" nowrap=3D"" valign=3D"bottom" style=3D"width:97.8pt;borde=
r-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-rig=
ht:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">658.1791 s<o:p></o:p></span></p>
</td>
<td width=3D"126" nowrap=3D"" valign=3D"bottom" style=3D"width:94.5pt;borde=
r-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-rig=
ht:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">658.4159 s<o:p></o:p></span></p>
</td>
<td width=3D"156" nowrap=3D"" valign=3D"bottom" style=3D"width:117.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:14.5pt">
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black">0.236847 s<o:p></o:p></span></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"2" type=3D"1">
<li class=3D"MsoPlainText" style=3D"mso-list:l1 level1 lfo2">If I only chan=
ge msleep(1) to usleep_range(10, 100), &nbsp;the polling time will reduced =
from 2 seconds to 0.2 seconds,<o:p></o:p></li></ol>
<p class=3D"MsoPlainText" style=3D"margin-left:.5in">So I change timeout fr=
om &#8220;timeout =3D 2000;&#8221; to &#8220;timeout =3D 20000;&#8221;<o:p>=
</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:yellow;mso-highlight:ye=
llow">host dmesg &nbsp;with udelay_range(10, 100) in amdgpu</span>:<o:p></o=
:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:aqua;mso-highlight:aqua=
">[&nbsp; 295.903102] gim info libgv: [4:0:0][amdgv_sched_enter_full_access=
:877] VF0 entered full access mode.</span><o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 295.906661] gim info libgv: [4:0:0][amdgv=
_ih_iv_ring_entry_process:254] PF_VF_MSGBUF_ACK received<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 296.052903] gim info libgv: [4:0:0][amdgv=
_ih_iv_ring_entry_process:192] VF_PF_MSGBUF_VALID received<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 296.052910] gim info libgv: [4:0:0][amdgv=
_ih_iv_ring_entry_process:205] Received Event: VF0, event =3D 0x2<o:p></o:p=
></p>
<p class=3D"MsoPlainText">[&nbsp; 296.052914] gim info libgv: [4:0:0][amdgv=
_sched_event_queue_push_ex:193] queue event REL_GPU_INIT(0xef01) for VF0 of=
 block(0xf0)<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 296.052934] gim info libgv: [4:0:0][amdgv=
_sched_process_event:1582] process event REL_GPU_INIT (0xef01) for VF0 of b=
lock (0xf0)<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 296.052944] gim info libgv: [4:0:0][navi1=
2_gpuiov_set_mmsch_vfgate:904] mmsch mb ints disabled schedid =3D 4<o:p></o=
:p></p>
<p class=3D"MsoPlainText">[&nbsp; 296.053334] gim info libgv: [4:0:0][navi1=
2_psp_v11_set_mb_int:632] psp mailbox disabled for VF0<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:aqua;mso-highlight:aqua=
">[&nbsp; 296.053513] gim info libgv: [4:0:0][amdgv_sched_exit_full_access:=
976] VF0 exited full access.</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:yellow;mso-highlight:ye=
llow">Host demsg with msleep(1) in amdgpu</span>:<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:aqua;mso-highlight:aqua=
">[&nbsp; 658.179053] gim info libgv: [4:0:0][amdgv_sched_enter_full_access=
:877] VF0 entered full access mode.</span><o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 658.182648] gim info libgv: [4:0:0][amdgv=
_ih_iv_ring_entry_process:254] PF_VF_MSGBUF_ACK received<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 658.415227] gim info libgv: [4:0:0][amdgv=
_ih_iv_ring_entry_process:192] VF_PF_MSGBUF_VALID received<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 658.415237] gim info libgv: [4:0:0][amdgv=
_ih_iv_ring_entry_process:205] Received Event: VF0, event =3D 0x2<o:p></o:p=
></p>
<p class=3D"MsoPlainText">[&nbsp; 658.415241] gim info libgv: [4:0:0][amdgv=
_sched_event_queue_push_ex:193] queue event REL_GPU_INIT(0xef01) for VF0 of=
 block(0xf0)<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 658.415299] gim info libgv: [4:0:0][amdgv=
_sched_process_event:1582] process event REL_GPU_INIT (0xef01) for VF0 of b=
lock (0xf0)<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 658.415311] gim info libgv: [4:0:0][navi1=
2_gpuiov_set_mmsch_vfgate:904] mmsch mb ints disabled schedid =3D 4<o:p></o=
:p></p>
<p class=3D"MsoPlainText">[&nbsp; 658.415719] gim info libgv: [4:0:0][navi1=
2_psp_v11_set_mb_int:632] psp mailbox disabled for VF0<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:aqua;mso-highlight:aqua=
">[&nbsp; 658.415900] gim info libgv: [4:0:0][amdgv_sched_exit_full_access:=
976] VF0 exited full access.</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">----------------------------------------------------=
------------------
<o:p></o:p></p>
<p class=3D"MsoNormal">BW<o:p></o:p></p>
<p class=3D"MsoNormal">Pengju Zhou<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: Paul Menzel &lt;<a href=3D"mailto:pmenzel@m=
olgen.mpg.de">pmenzel@molgen.mpg.de</a>&gt;
<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: Friday, December 25, 2020 6:44 AM<o:p></o:p=
></p>
<p class=3D"MsoPlainText">To: Zhou, Peng Ju &lt;<a href=3D"mailto:PengJu.Zh=
ou@amd.com">PengJu.Zhou@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.o=
rg">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander &lt;<a href=3D"ma=
ilto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Koenig, =
Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig@=
amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Subject: Re: [PATCH] drm/amdgpu: reduce the full =
access time by about 50ms<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Dear Peng Ju,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thank you for your patch.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Am 24.12.20 um 07:04 schrieb pengzhou:<o:p></o:p>=
</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Could you please configure your name in git:<o:p>=
</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp; git config --global user=
.name &quot;Peng Zhou&quot; # or Peng Ju Zhou<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Also, please mention PSP in some way in the git c=
ommit message summary.
<o:p></o:p></p>
<p class=3D"MsoPlainText">Maybe:<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; drm/amdgpu: Reduce delay in PSP command subm=
it by &#8230;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; The function msleep(1) can be delay to 10+ m=
s sometimes, which
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; contributes a big delay during the full acce=
ss time.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Do you have the Linux log messages with timestamp=
s, where the delay can be seen?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; Changing msleep(1) to usleep_range(10, 100) =
and it can reduce about
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; 50ms delay during full access time.<o:p></o:=
p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">(Please wrap lines after 75 characters.)<o:p></o:=
p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">`usleep_range(10, 100)` is 100 =ECs which is less=
 then 1 ms (=3D 1.000 =ECs).
<o:p></o:p></p>
<p class=3D"MsoPlainText">What datasheet specifies the needed delays?<o:p><=
/o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; Signed-off-by: pengzhou &lt;<a href=3D"mailt=
o:PengJu.Zhou@amd.com">PengJu.Zhou@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Change-Id: I151a07c55068d5c429553ef0e6668f02=
4c0c0f3d<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; ---<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgp=
u_psp.c | 2 +-<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), =
1 deletion(-)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdg=
pu_psp.c <o:p>
</o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt; index 523d22db094b..ef69051681cf 100644<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.=
c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.=
c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -282,7 +282,7 @@ psp_cmd_submit_buf(struc=
t psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_intr =3D amdgpu_ras_intr_triggered();<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras_intr)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; msleep(1);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; usleep_range(10, 100);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">With `timeout =3D 2000`, this was a maximum of tw=
o seconds (or even 20 seconds judging from your commit message). With your =
change it seems the waiting time is reduced to 0.2 seconds.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">I do not understand, how you reach 50 ms in the c=
ommit message title?
<o:p></o:p></p>
<p class=3D"MsoPlainText">Only if the msleep would take 50 ms, which is unl=
ikely.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(psp-&gt;adev, NU=
LL);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">It&#8217;s great to see these kind of optimizatio=
ns, as amdgpu takes 400 ms to load on my system.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">In a followup the logging should be improved too.=
 Maybe, print a warning, should it take longer than five milliseconds.<o:p>=
</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">I tested that it still boots on my MSI B350M MORT=
AR (MS-7A37) with AMD Ryzen 3 2200G, but couldn&#8217;t determine if the pa=
tch improved the boot time in anyway due to absent logging.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Kind regards,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Paul<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4371898E35F11AA52AE238DBF8DC0DM6PR12MB4371namp_--

--===============1094381649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1094381649==--
