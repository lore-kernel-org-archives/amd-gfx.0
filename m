Return-Path: <SRS0=M3Em=GD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA3CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 05:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B91B2158C
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 05:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B91B2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA5A89B05;
	Thu, 31 Dec 2020 05:15:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DE489B05
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Dec 2020 05:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpE3p7VGlHx28z34yHuOhgnm3S5jUaaqvZFgiLQLV3cwc3IeYVrqkis8Sb1Se4g8bX1SvWaRAxgtXV07hAon0IA8N2Khu9sCPPNccn7bgkxyRRZi69MfF88HKJAJn7AOse/mh3r9fqkIWA3Kin04v7JJKLbUiJ3kVeh4eQs4pUmZgt46PJbZ/BMZSf4fXKkYMKup2R/9iEYBk1rXUdF2+qcuzoU4jSsZhapwnzydPzytbxovxE2CaelawrgRFWapmy0sW6GS+NM+uYeR2nQBkPBEYUak5bC/UI/SD49CQIpZsh2EQbs9Sh0cYKWmRHzs9qZ325IF0cdSGSJfh3IHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jShsGfbwG5qo5Uo/uynxa67gLKc371xgzFN8mEDpH0w=;
 b=ZnHyje1hKIG8Wp9Kh2cPhlLl57/kyGqheSBSBU3uwwJwjzJtJY07tqVErTYngozhTvtEOHqNfn2dx8GcFnyF17ujL04zzYpg71u3IqrXhZkpFp7tEYmplVxbIgRfA9iiOCWGXMoTPq7biWzs9qMkq84J9GhTmsUIHb1ZQ0MrPTdI+B/alQd6COddndhKRci4tB4ru2GLLmdHymTy5yJi6LvRrYA8CkQ9DDd3zjc7fwZl7Z9sf5tgAYQT+X+W+UDE1lr6GvbG7HsWGIZgV4JHpBzYylGvLzu/26nOLVY7I7yQG1mZIpSF1pl9jV/E41mXza6rruWmu8POCkqDBbYgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jShsGfbwG5qo5Uo/uynxa67gLKc371xgzFN8mEDpH0w=;
 b=H272D+EntaAvs3O60NA3sl1k0tFtg6v1qY41WHsbGQayWj9i7y61H0ZGxJ2xUrotXFn69Tk/3rqSI5stDcnowhrnBD3YcwiFJRRDRW35oGk5PGqq2HFO+oM8etXNmCbH6ESaT6FU/XH56QdSvfimghnA8Szl0m0i49g/QDyefkY=
Received: from DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23)
 by DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Thu, 31 Dec
 2020 05:15:39 +0000
Received: from DM6PR12MB4371.namprd12.prod.outlook.com
 ([fe80::19b9:e4e6:c55e:29a8]) by DM6PR12MB4371.namprd12.prod.outlook.com
 ([fe80::19b9:e4e6:c55e:29a8%5]) with mapi id 15.20.3721.020; Thu, 31 Dec 2020
 05:15:39 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
Thread-Topic: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
Thread-Index: AQHW2bqz4CwQrLh3LEK7B0BSA355aKoG2SCAgABJvACAAIH/AIAJDnLA
Date: Thu, 31 Dec 2020 05:15:39 +0000
Message-ID: <DM6PR12MB43719DC1EC0F002EF19F9E68F8D60@DM6PR12MB4371.namprd12.prod.outlook.com>
References: <20201224060434.18144-1-PengJu.Zhou@amd.com>
 <d35f603a-dbbe-fba4-c1c5-79b4f00e3ccd@molgen.mpg.de>
 <DM6PR12MB4371898E35F11AA52AE238DBF8DC0@DM6PR12MB4371.namprd12.prod.outlook.com>
 <ca8968fd-f485-2b72-ffe1-d1562a2be250@molgen.mpg.de>
In-Reply-To: <ca8968fd-f485-2b72-ffe1-d1562a2be250@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-31T05:15:18Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=436c4394-3eb7-4d83-98aa-0000ea53257b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-31T05:15:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 191f22af-2701-42a7-a82e-00003196ac28
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
x-ms-office365-filtering-correlation-id: e7f6493f-67bb-4a23-01d5-08d8ad4b1d2f
x-ms-traffictypediagnostic: DM6PR12MB4880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB488071894429D2D62003DD31F8D60@DM6PR12MB4880.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egj1/Wj6pFeFji5VPAqHlbK/djU/a7Xivwa2xlf2oNtigPq0jXzt9SZLjMg3R5yAxHnQZnF9mEeGLa23Dbbzu0zVx1QjBMS4AyB67hW9/4qnKov3cWVWKLJcTaXZPzZ+FbEpii8caRSa2kXJ/XqigRSH0X/SHjUtppF8QsjwXGEH56l0qaY46ZNFB+g3EGG1MKYG9wbXQKRaySeG85z4BRFM5Wbmw2wV+8ifP1t9oq68eICRlYsFMFl8Pb5H6VZLL0Hwd+otKA3dz4O6gml1kt6ZJbi+6Wl5WHIRRI8mCu0ZmQGiar+XaldLU3cS/EDY1/9AtZBn+PkboelakTBZXB9+33T6vtvtHo6kxwXmqgXeCf3SNf3C1V7tQYpoxYjhN84BxQOwjpYX1iD/GWoItmRuxQngEKSxq2xWji6DOaAE3O2ijo3i6KXipOT4mkjktM7oDXwCA/QkGo7/DV8hDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4371.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(54906003)(7696005)(71200400001)(8676002)(4326008)(52536014)(83380400001)(5660300002)(66946007)(8936002)(76116006)(6506007)(53546011)(45080400002)(66446008)(478600001)(966005)(66556008)(64756008)(66476007)(316002)(33656002)(6916009)(86362001)(186003)(26005)(9686003)(55016002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Z1i7LSjPVCS1yGLU64QH9WuJlT9U3V/CdSkr6yxQ2YEFjmt3ct+bx7xPMbx6?=
 =?us-ascii?Q?gGmZHOfXAUlT7MBYCi8Dusx0kKgXs4EnbAVjZq4ABlKlg0zpR5Th0fGkR8cY?=
 =?us-ascii?Q?GFl0o/wpF6QSphksOKMXY+xU0LRX6gTVGDoMPILDBDQ3XEtbsokPGY65ME8p?=
 =?us-ascii?Q?knW9s77mREjM3ufOuEwifYEC5xyY4ARW+OaQO08wSc7K/uQaarBPi1XJrbHC?=
 =?us-ascii?Q?n4mWyMUzADPxmOkfzfa+L3nttI87sqGtvomJel0ebnGd+0eok4r8iS5hsmgR?=
 =?us-ascii?Q?x4m+r1O2k00+IEdHKImxA0FvNL5U99FQfdwz2W0OEtwCoEE6mM42TN8VxfdQ?=
 =?us-ascii?Q?LzcktCvFv0xaoCyV06cF5KnGvOmpa411iAXVpTY5T7o11cGJ+2V9LMP7610S?=
 =?us-ascii?Q?3/XekRyyQAtglLBJ0rRK5TB5FSKouKwtqZjy8DhWYCvKulcoqIP3VtkKqdOr?=
 =?us-ascii?Q?zA178+3gE/KZ3uKDHTLbWBPlN2HZkG32PSjedZ6669P2yEZYls21euDF9uhz?=
 =?us-ascii?Q?jXu2pa3mIF2RMG+MFnrRgBvqvuJAAAXudo6VbOcUNWmQwLnqRYZDZpC2tkkK?=
 =?us-ascii?Q?N8ji+xUABT2OdB5q7KjAosAehqMbEMPfFRerVhfeI4VHfPvciG+DRKzKZCeh?=
 =?us-ascii?Q?JJ5nYM2WvbAzSTG3pZLIwNshJeee8D3MPoxnquoGJlcPnbK7Ssm+cIqr7FUn?=
 =?us-ascii?Q?wx+dX9vDC6ANgPX2D6j8u/ayMQipFmSFTavc+hHwCew/TULcLBdD7wmm7Zg+?=
 =?us-ascii?Q?rR32DZW09tIezE84RDfoQlAj5gCl6kYKE80K/pxCagJxP49eC0O90hNd7dsf?=
 =?us-ascii?Q?aXrbJTl9i1Llex0p27V0qYmLqyKZMvDtBHpM2VoEa8IiD4M2EEGsUiq6laDE?=
 =?us-ascii?Q?wyqsZFJYHZDQ0zH/J85mPuu8hOpP9NMNDdlsye/chR9VbbeB7DoOxEIJtGVb?=
 =?us-ascii?Q?i+DB8++yP80zSXD9Eu6oORxnUS2wket8CPll5aYqh9s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f6493f-67bb-4a23-01d5-08d8ad4b1d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2020 05:15:39.5652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLkadqzreHRYzCiL3Ze0EvOYptIU69HVQoDoMsS8sqpQziG6KogrnsWHxTXvRdH1YGtrUsEDEQWDOY+z/MyX0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Paul
Thanks for you kindly instruction,
I have no hardware spec.


---------------------------------------------------------------------- 
BW
Pengju Zhou




-----Original Message-----
From: Paul Menzel <pmenzel@molgen.mpg.de> 
Sent: Friday, December 25, 2020 6:53 PM
To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: reduce the full access time by about 50ms

Dear Peng Ju,


For mailing lists, it would be great if you used a mail user agent, which supports quoting (interleaved style), and if you sent plain text messages and no HTML [1].

Am 25.12.20 um 07:34 schrieb Zhou, Peng Ju:

[...]

> 1.  The 50 ms is the whole full access time reduced, not one 
> msleep(1),
> 
> During amdgpu driver init, it will hit msleep(1) several times which increased the total time of full access.

In your logs at the end of your reply, it is a 360 ms difference?

> I load amdgpu in the guest VM and collect VF's full access time in the host, host dmesg  was listed in the below:
> In this time, the time reduced : 0.236847 s - 0.150411 s = 86.436 ms .
> (The reason why it is 80+ms is that I add some code to program one 
> register by psp. )
> 
> VF Start Full access
> VF exit full access
> VF full access time
> msleep(1)
> 295.9031 s
> 296.0535 s
> 0.150411 s
> usleep_range(10, 100)
> 658.1791 s
> 658.4159 s
> 0.236847 s

Is this some output of `time`?

Do you have more details for your hardware?

> 1.  If I only change msleep(1) to usleep_range(10, 100),  the polling 
> time will reduced from 2 seconds to 0.2 seconds,
> 
> So I change timeout from "timeout = 2000;" to "timeout = 20000;"

Sounds good to not change behavior, but I'd be interested where the two seconds comes from.

> host dmesg  with udelay_range(10, 100) in amdgpu:
> 
> [  295.903102] gim info libgv: [4:0:0][amdgv_sched_enter_full_access:877] VF0 entered full access mode.
> [  295.906661] gim info libgv: 
> [4:0:0][amdgv_ih_iv_ring_entry_process:254] PF_VF_MSGBUF_ACK received 
> [  296.052903] gim info libgv: 
> [4:0:0][amdgv_ih_iv_ring_entry_process:192] VF_PF_MSGBUF_VALID 
> received [  296.052910] gim info libgv: 
> [4:0:0][amdgv_ih_iv_ring_entry_process:205] Received Event: VF0, event 
> = 0x2 [  296.052914] gim info libgv: 
> [4:0:0][amdgv_sched_event_queue_push_ex:193] queue event REL_GPU_INIT(0xef01) for VF0 of block(0xf0) [  296.052934] gim info libgv: [4:0:0][amdgv_sched_process_event:1582] process event REL_GPU_INIT (0xef01) for VF0 of block (0xf0) [  296.052944] gim info libgv: [4:0:0][navi12_gpuiov_set_mmsch_vfgate:904] mmsch mb ints disabled schedid = 4 [  296.053334] gim info libgv: [4:0:0][navi12_psp_v11_set_mb_int:632] psp mailbox disabled for VF0 [  296.053513] gim info libgv: [4:0:0][amdgv_sched_exit_full_access:976] VF0 exited full access.
> 
> Host demsg with msleep(1) in amdgpu:
> 
> [  658.179053] gim info libgv: [4:0:0][amdgv_sched_enter_full_access:877] VF0 entered full access mode.
> [  658.182648] gim info libgv: 
> [4:0:0][amdgv_ih_iv_ring_entry_process:254] PF_VF_MSGBUF_ACK received 
> [  658.415227] gim info libgv: 
> [4:0:0][amdgv_ih_iv_ring_entry_process:192] VF_PF_MSGBUF_VALID 
> received [  658.415237] gim info libgv: 
> [4:0:0][amdgv_ih_iv_ring_entry_process:205] Received Event: VF0, event 
> = 0x2 [  658.415241] gim info libgv: 
> [4:0:0][amdgv_sched_event_queue_push_ex:193] queue event REL_GPU_INIT(0xef01) for VF0 of block(0xf0) [  658.415299] gim info libgv: [4:0:0][amdgv_sched_process_event:1582] process event REL_GPU_INIT (0xef01) for VF0 of block (0xf0) [  658.415311] gim info libgv: [4:0:0][navi12_gpuiov_set_mmsch_vfgate:904] mmsch mb ints disabled schedid = 4 [  658.415719] gim info libgv: [4:0:0][navi12_psp_v11_set_mb_int:632] psp mailbox disabled for VF0 [  658.415900] gim info libgv: [4:0:0][amdgv_sched_exit_full_access:976] VF0 exited full access.

I added a DRM_WARN to print out `timeout` value.

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -285,6 +285,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>                 usleep_range(10, 100);
>                 amdgpu_asic_invalidate_hdp(psp->adev, NULL);
>         }
> +       DRM_WARN("PSP timeout = %i\n", timeout);
>  
>         /* We allow TEE_ERROR_NOT_SUPPORTED for VMR command and PSP_ERR_UNKNOWN_COMMAND in SRIOV */
>         skip_unsupport = (psp->cmd_buf_mem->resp.status == 
> TEE_ERROR_NOT_SUPPORTED ||

```
$ dmesg | grep timeout
[   57.316303] [drm] PSP timeout = 1993
[   57.319311] [drm] PSP timeout = 1997
[   57.322299] [drm] PSP timeout = 1997
[   57.325297] [drm] PSP timeout = 1997
[   57.328299] [drm] PSP timeout = 1997
[   57.338306] [drm] PSP timeout = 1990
[   57.340363] [drm] PSP timeout = 1998
[   57.350295] [drm] PSP timeout = 1990
[   57.352304] [drm] PSP timeout = 1998
[   57.355306] [drm] PSP timeout = 1997
[   57.362313] [drm] PSP timeout = 1997
[   57.364304] [drm] PSP timeout = 1998
[   57.366382] [drm] PSP timeout = 1998
[   57.376299] [drm] PSP timeout = 1990
[   57.382302] [drm] PSP timeout = 1994
[   57.387311] [drm] PSP timeout = 1996
[   57.390315] [drm] PSP timeout = 1997
[ 3038.312317] [drm] PSP timeout = 1997
[ 3038.314330] [drm] PSP timeout = 1998
[ 3038.316323] [drm] PSP timeout = 1998
[ 3038.325310] [drm] PSP timeout = 1991
[ 3038.960783] [drm] PSP timeout = 1993
[ 3038.963769] [drm] PSP timeout = 1997
[ 3038.966787] [drm] PSP timeout = 1997
[ 3038.969787] [drm] PSP timeout = 1997
[ 3038.972764] [drm] PSP timeout = 1997
[ 3038.981763] [drm] PSP timeout = 1991
[ 3038.983781] [drm] PSP timeout = 1998
[ 3038.993787] [drm] PSP timeout = 1990
[ 3038.995781] [drm] PSP timeout = 1998
[ 3038.998767] [drm] PSP timeout = 1997
[ 3039.001785] [drm] PSP timeout = 1997
[ 3039.004782] [drm] PSP timeout = 1997
[ 3039.007763] [drm] PSP timeout = 1997
[ 3039.018786] [drm] PSP timeout = 1989
[ 3039.023768] [drm] PSP timeout = 1995
[ 3039.026786] [drm] PSP timeout = 1997
[ 3039.029786] [drm] PSP timeout = 1997
[ 3096.984077] [drm] PSP timeout = 1998
[ 3096.985076] [drm] PSP timeout = 1999
[ 3096.988078] [drm] PSP timeout = 1997
[ 3096.997087] [drm] PSP timeout = 1991
[ 3097.638068] [drm] PSP timeout = 1992
[ 3097.642050] [drm] PSP timeout = 1996
[ 3097.646069] [drm] PSP timeout = 1996
[ 3097.649067] [drm] PSP timeout = 1997
[ 3097.652070] [drm] PSP timeout = 1997
[ 3097.661064] [drm] PSP timeout = 1991
[ 3097.663064] [drm] PSP timeout = 1998
[ 3097.672066] [drm] PSP timeout = 1991
[ 3097.674044] [drm] PSP timeout = 1998
[ 3097.676042] [drm] PSP timeout = 1998
[ 3097.678063] [drm] PSP timeout = 1998
[ 3097.681067] [drm] PSP timeout = 1997
[ 3097.684046] [drm] PSP timeout = 1997
[ 3097.695063] [drm] PSP timeout = 1989
[ 3097.700067] [drm] PSP timeout = 1995
[ 3097.704063] [drm] PSP timeout = 1996
[ 3097.707067] [drm] PSP timeout = 1997
[ 3565.319243] [drm] PSP timeout = 1998
[ 3565.320243] [drm] PSP timeout = 1999
[ 3565.322243] [drm] PSP timeout = 1998
[ 3565.331248] [drm] PSP timeout = 1991
[ 3565.900677] [drm] PSP timeout = 1992
[ 3565.904677] [drm] PSP timeout = 1996
[ 3565.907675] [drm] PSP timeout = 1997
[ 3565.910676] [drm] PSP timeout = 1997
[ 3565.913676] [drm] PSP timeout = 1997
[ 3565.922671] [drm] PSP timeout = 1991
[ 3565.924671] [drm] PSP timeout = 1998
[ 3565.934677] [drm] PSP timeout = 1990
[ 3565.936673] [drm] PSP timeout = 1998
[ 3565.939676] [drm] PSP timeout = 1997
[ 3565.942677] [drm] PSP timeout = 1997
[ 3565.945672] [drm] PSP timeout = 1997
[ 3565.948671] [drm] PSP timeout = 1997
[ 3565.959677] [drm] PSP timeout = 1989
[ 3565.964675] [drm] PSP timeout = 1995
[ 3565.967676] [drm] PSP timeout = 1997
[ 3565.970676] [drm] PSP timeout = 1997
[ 4194.378894] [drm] PSP timeout = 1997
[ 4194.380890] [drm] PSP timeout = 1998
[ 4194.383894] [drm] PSP timeout = 1997
[ 4194.392890] [drm] PSP timeout = 1991
[ 4195.054442] [drm] PSP timeout = 1992
[ 4195.057434] [drm] PSP timeout = 1997
[ 4195.060441] [drm] PSP timeout = 1997
[ 4195.063442] [drm] PSP timeout = 1997
[ 4195.066444] [drm] PSP timeout = 1997
[ 4195.075438] [drm] PSP timeout = 1991
[ 4195.077438] [drm] PSP timeout = 1998
[ 4195.087464] [drm] PSP timeout = 1990
[ 4195.089465] [drm] PSP timeout = 1998
[ 4195.092444] [drm] PSP timeout = 1997
[ 4195.095464] [drm] PSP timeout = 1997
[ 4195.098464] [drm] PSP timeout = 1997
[ 4195.101438] [drm] PSP timeout = 1997
[ 4195.112463] [drm] PSP timeout = 1989
[ 4195.117463] [drm] PSP timeout = 1995
[ 4195.120443] [drm] PSP timeout = 1997
[ 4195.123462] [drm] PSP timeout = 1997
```

So, minimum is 1990.

I saw you resent the updated patch. Thank you for that. Please tag those with `v2` (v3, ...).

I'd still extend the commit message with more information. Timing changes are always quite hardware dependent, so a lot of details are necessary.

If you got Reviewed-by tags, you can add them to the iterated patch.


Kind regards,

Paul


[1]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FPosting_style%23Interleaved_style&amp;data=04%7C01%7CPengJu.Zhou%40amd.com%7C8b8f9a9b252f4a47a60808d8a8c34dd2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637444904111803810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=E75h2KWQ%2B6G03oJYxdFk%2FN0mMUv0DUcBv3ULiBWBTu8%3D&amp;reserved=0
[2]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuseplaintext.email%2F&amp;data=04%7C01%7CPengJu.Zhou%40amd.com%7C8b8f9a9b252f4a47a60808d8a8c34dd2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637444904111803810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=L5ZjjzTjfueKGdEPINy1Dz7h62ZsJhTaLgbYuyru1HY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
