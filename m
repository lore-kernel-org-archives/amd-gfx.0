Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3524AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 09:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF6810E4A6;
	Thu, 20 Jan 2022 09:39:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D324310E210
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAf/5StyFh5tfM3Uv8jAL4TBsLty/60z/hrz6HziiRAlsZZDuqA/OUYqsxlpwmothmtLmz70DRa0pQL1Z1XbjVevX0ZnUEJkj5JgFTr3HXOYyJTpULgQPiru55OAPseltyqK7OPxDGLi84sgReYAnW07g6xQ84eF35PGCHSb20eiq+gSwRLnJ2n1UDQKQ/MRGm2nBAEJ3Szzy18mJfzlwiXlyfRABKv5yHFeWlJKELuQJsu8fBGpSlzKggP2U56os6VTzjBZ3xVBAFP9vw9rhfuIQq/TRdddizzETGN0oRLW4c63wgHcjhqF6XSnxpRnO1KyUGhGaoMjGLt2JzW+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrDC4bVQkHJOIVUOmwBqTbQ3qFYaTlWAxNDUUngZkKc=;
 b=cNXl/pPO38ckJw8dqVMawDIRzIU90UHIPA1x74EZ3K9gGRl7ILuX+ygeqF9BiGxodNuJHCSDdvy60wI416bqYDUtbx1jx4FpBAbu5PAaGKhbexFpkK3MGCVlqF/in8yM7F9Vap0b5ZVxD3yAXFSO+xbG9CJHfBCCjBl8uv76GQXJjcmDCoEf/cD6b9rO4oOYoQzZCHxAcVt7Iid93lGwdoCTmevh2AXyU5ED1JNZqGsIwu6x+9Z56o2r11g3mAtd1EORDRv6/m6VXAv+H7ueGnPpzSeBUhyy1j5GmIpf1Fsx41iy2b8sph2VdYlXBFjxng5a09ChXW5G28x6ghpbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrDC4bVQkHJOIVUOmwBqTbQ3qFYaTlWAxNDUUngZkKc=;
 b=bN7cexqT1QaDSmN/+WP0PH/fOYZfiH0EefVLhmoTejc9FK3pz6ZqjF77DPRmkzclfeQnZtI46Dtfl6EDDPdxeJX//WFXvXKcuwxkNuyr9S/VW+HPzQW1CBv76cSx7YYoldmP2F4QgDjFmFCAFFTlVAd6CrsG7WxXuBKrFxbXBDE=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by BN8PR12MB3057.namprd12.prod.outlook.com (2603:10b6:408:64::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 09:39:23 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 09:39:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table when
 mmio is blocked
Thread-Topic: [PATCH] drm/amdgpu: force using sdma to update vm page table
 when mmio is blocked
Thread-Index: AQHYDOLz9NJJp1Ao/ket4CY+uhKskaxrmDUXgAAF6ICAAACajoAAAvyAgAAHlZo=
Date: Thu, 20 Jan 2022 09:39:22 +0000
Message-ID: <CO6PR12MB5473612CFBEC14CB9D6315E0825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220119031610.832211-1-KevinYang.Wang@amd.com>
 <CO6PR12MB54731E9FBF54A2E86A320419825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
 <95be3a20-ac92-9acd-9600-3caf9223c67a@amd.com>
 <CO6PR12MB54735F709AACC151C3B66900825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
 <0a753643-dffe-8560-8923-4e4cfcbfd7e1@amd.com>
In-Reply-To: <0a753643-dffe-8560-8923-4e4cfcbfd7e1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T09:39:22.288Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a2c03ed-f603-49a2-cd6c-08d9dbf8bda6
x-ms-traffictypediagnostic: BN8PR12MB3057:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3057C3DE2A692B745382869F825A9@BN8PR12MB3057.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvbIJmdI9NOhk/sSXZYWJRUIxIcSR+tWiFZxq2UBzJs65u4RhwS+9tR+EvZ/W1BfHnRB1nyrBJtr9qthP+iJKeCGHeYHGvZJotE5E+OsKLDDuJBU97xu/19HS+3EtjkdAl4NNoIBlBGmUqdaaYnDPe2igjkzXfJbyJOLrwc+adMLMj05YiW8agNa2pkZua00BoDQNz6Ml1PvbWpVLeKQu2+kGJ58A9EUtqQEzjL6WH6wUK5LhTSK/ymWKfpfZOHiZlWEps/0m8xgfdnkGFtgg1rcb0iykz7HAYovLYuNWeKsTkaii34ricw/AWLGQEQ7x8czCejsTEXkPBuvbAAyRPyEISYM+3gF/bfas1T9iyRiuQ6eCr5vOJLUvVVKg8KAgs0a4FbDNjmkyjJH/OSIJ6UVg3VLzxm4xUJnkuhnMW6baXXuW+P+6eabMfWwApvw75DjR3HOK9QoLfuhQpkDCTroem3QRQawgiVAvxLYCn6lf6y3RD9QZCJCaQGY6CGUZvGmHJivC1PzJ11LupGHDB/AhkxHptVa7De/QgiX3kyLYo5HBkzSpz9al+6JJbgKbXCMXdZAAjKa5lXTc7EytwXhcH2cfGsMLf6ud4SO5Z+pHjK9pLW3yxkYVvifxsvYRX7WpReB4V6lamz4EEsc0ora24/1dlyZZ3e8YHqqPeOqmC2a0zUaIFmS82Uq0dtoqyNpbAKqniUh1+44x2iDyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6636002)(83380400001)(54906003)(122000001)(4326008)(38100700002)(508600001)(19627405001)(71200400001)(8676002)(2906002)(110136005)(7696005)(316002)(9686003)(55016003)(15650500001)(52536014)(186003)(86362001)(38070700005)(66946007)(53546011)(26005)(33656002)(8936002)(91956017)(64756008)(76116006)(66556008)(66476007)(66446008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GEzgLsf/uU303MHS2Yv2YF8yGJpi5mpnKSvx6CgFmNCz6MC6/rxwT0fyhv?=
 =?iso-8859-1?Q?+pfSz656uE0PrgUKhMDRrM3JnDN3iPIP8IxtFzJygTvKdCZHCKKqGu+TkC?=
 =?iso-8859-1?Q?2UiCrdf6E1Fk+rQMX2DPXetUFBfkim4FTLMm3rUMii+MTn+GsUU3yGhv8o?=
 =?iso-8859-1?Q?72jAQU9lnmVe672X9kuPhiVPWzSUoBpsre3W2E7brMfIJLTqQKXVhvuzxS?=
 =?iso-8859-1?Q?FTOD1F6YWbkgtOXtpZH8+i0Io0b8CX6AM8JKasYUzvfuSWOtyeIoqYjQms?=
 =?iso-8859-1?Q?iDAhILnd77Muhk3LgHsGIhsEXtDQa4iXxmjY3nRBHWFH0HIloPzhHpHTzl?=
 =?iso-8859-1?Q?cxElKZcFetht0AXqoD01/QWr84f8LN/GjWLy5KIiFzbEUXHO7IDsDw8J2U?=
 =?iso-8859-1?Q?jZ278vc2oA81JWqzquyjgWeB9m6vNdbQWP5v/iKJ6M3Jitsg4bLmIF/XZf?=
 =?iso-8859-1?Q?yLSblHCbCM3bmfGUXSBk+sn4igiulqE5suxdR8t9F13qId9VO+ERRR8ivm?=
 =?iso-8859-1?Q?lAW+MdtplehwFhHS7SNueTDPNmD0XhBoWIZwFLKMwKyQc6b42ZF22JE6UY?=
 =?iso-8859-1?Q?6MCbL6jiPERXPVxsX7fpo/wfAmx0EfMmk+IjxYwnat13joRyNeY3pojjOb?=
 =?iso-8859-1?Q?11ELcasHiGM0iIzC2D3Eo1yhmPa7ZlppuH8RjG1WMwgNHpXP9fb03EQ92d?=
 =?iso-8859-1?Q?ajXvKMikd0h3d7Lgnd59wqSfCy3bQmxDJUPdPvZKbcniZxRezjO29JM/Li?=
 =?iso-8859-1?Q?tRr90Trkq5JqprpTrbvB6KrL+2Icwlr6D/GppWHlBv9tTxTPyNiY/yFSVE?=
 =?iso-8859-1?Q?se/McGtJ3l7hyB0tWZmIxHl3aOAcVkFFJVNdbFrjl8y2IdqqW8BqILwO4J?=
 =?iso-8859-1?Q?9Ea5/ebOIWGmVmM3QjLzy/9efCpMzIYRnFgFsxuTk8JhuVDxQUfVeN3d3M?=
 =?iso-8859-1?Q?mKduhHZJWdftn2fsq4MwjStOmafHgkukzfsn63/R00LxXBuu/6FFKpsYIt?=
 =?iso-8859-1?Q?p7IOUINAA9LshGWhkHLUVeRC6U3qgpV86Ek2m/rHnSOWzc4QURtpzrP7mF?=
 =?iso-8859-1?Q?t6YNET2TdJV+oREPcS9Yy0NtVD7oztn75iLpWgai+ZJZzmczFLC0+hYXSh?=
 =?iso-8859-1?Q?F6slsV+lZ44dmU/yboQMUlu8Ipt7nCRNsGLOi9JxDI0CNA2t8AMTE5E45K?=
 =?iso-8859-1?Q?TuDjecKOIJPlZ6NlloUfefTcqqlmS/eCyMa0JFsdRamZ8AGWcWZbXLuyhq?=
 =?iso-8859-1?Q?y/HjXYa4fwFBm0Pj/5O9xz9geRBK8Ts/ItIXhNf5maukZGHouWVRCFHUhK?=
 =?iso-8859-1?Q?4lyDbP9JifE7Zd22L37wPhMWM0ekQaIRCGRM3sy3CezL6HyhpnzklGhrNE?=
 =?iso-8859-1?Q?IHfMgf7rDZGV6Y/cIHBFS49pY39wniM3QC2MjQwMP9IiI3RLL2tK2CYHGy?=
 =?iso-8859-1?Q?Sdm/l+clbeprty67lxQzSdxAzx/SKDnO8rvOjUDHzIl7tRHxSmHOWck9NK?=
 =?iso-8859-1?Q?rnSYS2suMUCnt19fAeyzFTH6uYSgwkElWBohfbGsRXB4vFfVdmqVfpHXvZ?=
 =?iso-8859-1?Q?W/bz6dQSYuWwIVS0Q3kzK0zLK0ym8MsYNVibKvA5wvLcm7DSXohgq/uqws?=
 =?iso-8859-1?Q?0ssSZJySqntKM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473612CFBEC14CB9D6315E0825A9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2c03ed-f603-49a2-cd6c-08d9dbf8bda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 09:39:22.7802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bil3hKqyBvMj54SOTUS5zBz8IyFtQ2f+i+rbO9WBxJhBiKkpVw7hoLHEGPE5PKsX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3057
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Min, Frank" <Frank.Min@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473612CFBEC14CB9D6315E0825A9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thanks @Koenig, Christian<mailto:Christian.Koenig@amd.com>.

Best Regards,
Kevin
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, January 20, 2022 5:11 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Liu, Monk <Monk.Liu@amd.com>
Cc: Min, Frank <Frank.Min@amd.com>; Chen, Horace <Horace.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table w=
hen mmio is blocked

Hi Kevin,

well at least the HDP flush function has to work correctly or otherwise the=
 driver won't work correctly.

If the registers are not accessible any more we need to find a proper worka=
round for this.

One possibility would be to use the KIQ, another is a dummy write/read to m=
ake sure the HDP is flushed (check the hardware docs).

The third option would be to question if blocking the HDP registers is real=
ly a good idea.

The solution is up to you, but a workaround like proposed below doesn't rea=
lly help in any way.

Regards,
Christian.

Am 20.01.22 um 10:07 schrieb Wang, Yang(Kevin):

[AMD Official Use Only]

Hi Chris,

yes, I agree with your point.
and another way is that we can use KIQ to write HDP register to resolve HDP=
 can't R/W issue.
but it will cause some performance drop if use KIQ to programing register.

what is your ideas?

Best Regards,
Kevin
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Thursday, January 20, 2022 4:58 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com><mailto:KevinYang.Wang@amd.co=
m>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>; Deucher=
, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>; =
Liu, Monk <Monk.Liu@amd.com><mailto:Monk.Liu@amd.com>
Cc: Min, Frank <Frank.Min@amd.com><mailto:Frank.Min@amd.com>; Chen, Horace =
<Horace.Chen@amd.com><mailto:Horace.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table w=
hen mmio is blocked

Well NAK.

Even when we can't R/W HDP registers we need a way to invalidate the HDP or=
 quite a bunch of functions won't work correctly.

Blocking CPU base page table updates only works around the symptoms, but do=
esn't really solve anything.

Regards,
Christian.

Am 20.01.22 um 09:46 schrieb Wang, Yang(Kevin):

[AMD Official Use Only]

ping...

add @Liu, Monk<mailto:Monk.Liu@amd.com> @Koenig, Christian<mailto:Christian=
.Koenig@amd.com> @Deucher, Alexander<mailto:Alexander.Deucher@amd.com>

Best Regards,
Kevin
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com><mailto:KevinYang.Wang@amd.=
com>
Sent: Wednesday, January 19, 2022 11:16 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Min, Frank <Frank.Min@amd.com><mailto:Frank.Min@amd.com>; Chen, Horace =
<Horace.Chen@amd.com><mailto:Horace.Chen@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com><mailto:KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: force using sdma to update vm page table when =
mmio is blocked

when mmio protection feature is enabled in hypervisor,
it will cause guest OS can't R/W HDP regiters,
and using cpu to update page table is not working well.

force using sdma to update page table when mmio is blocked.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com><mailto:KevinYang.Wang@amd=
.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index b23cb463b106..0f86f0b2e183 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm)
         vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                     AMDGPU_VM_USE_CPU_FOR_GFX);

+       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && amdgpu_virt_=
mmio_blocked(adev))
+               vm->use_cpu_for_update =3D false;
+
         DRM_DEBUG_DRIVER("VM update mode is %s\n",
                          vm->use_cpu_for_update ? "CPU" : "SDMA");
         WARN_ONCE((vm->use_cpu_for_update &&
@@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm)
         /* Update VM state */
         vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                     AMDGPU_VM_USE_CPU_FOR_COMPUTE);
+
+       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && amdgpu_virt_=
mmio_blocked(adev))
+               vm->use_cpu_for_update =3D false;
+
         DRM_DEBUG_DRIVER("VM update mode is %s\n",
                          vm->use_cpu_for_update ? "CPU" : "SDMA");
         WARN_ONCE((vm->use_cpu_for_update &&
--
2.25.1




--_000_CO6PR12MB5473612CFBEC14CB9D6315E0825A9CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks <a id=3D"OWAAM159923" class=3D"P8b7u5KH31KY6Eljcf5yw mention ms-bgc-=
nlr ms-fcl-b" href=3D"mailto:Christian.Koenig@amd.com">
@Koenig, Christian</a>.</div>
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
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 20, 2022 5:11 PM<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;<br>
<b>Cc:</b> Min, Frank &lt;Frank.Min@amd.com&gt;; Chen, Horace &lt;Horace.Ch=
en@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: force using sdma to update vm page =
table when mmio is blocked</font>
<div>&nbsp;</div>
</div>
<div>Hi Kevin,<br>
<br>
well at least the HDP flush function has to work correctly or otherwise the=
 driver won't work correctly.<br>
<br>
If the registers are not accessible any more we need to find a proper worka=
round for this.<br>
<br>
One possibility would be to use the KIQ, another is a dummy write/read to m=
ake sure the HDP is flushed (check the hardware docs).<br>
<br>
The third option would be to question if blocking the HDP registers is real=
ly a good idea.<br>
<br>
The solution is up to you, but a workaround like proposed below doesn't rea=
lly help in any way.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<div class=3D"x_moz-cite-prefix">Am 20.01.22 um 10:07 schrieb Wang, Yang(Ke=
vin):<br>
</div>
<blockquote type=3D"cite">
<p align=3D"Left" style=3D"margin-top: 0px; margin-bottom: 0px;font-family:=
Arial; font-size:10pt; color:#0000FF; margin:5pt">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi Chris,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
yes, I agree with your point.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"color:rgb(0,0,0); font-family:Calibri,Arial,Helvetica,sans-s=
erif; font-size:12pt">and another way is that we can use KIQ to write HDP r=
egister to resolve HDP can't R/W issue.</span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"color:rgb(0,0,0); font-family:Calibri,Arial,Helvetica,sans-s=
erif; font-size:12pt">but it will cause some performance drop if use KIQ to=
 programing register.</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
what is your ideas?</div>
<span></span>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Christian.Koenig@amd.co=
m">&lt;Christian.Koenig@amd.com&gt;</a><br>
<b>Sent:</b> Thursday, January 20, 2022 4:58 PM<br>
<b>To:</b> Wang, Yang(Kevin) <a class=3D"x_moz-txt-link-rfc2396E" href=3D"m=
ailto:KevinYang.Wang@amd.com">
&lt;KevinYang.Wang@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated"=
 href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deucher, Alexander <a class=3D"x=
_moz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a>; Liu, Monk <a class=3D"x_moz-txt-link=
-rfc2396E" href=3D"mailto:Monk.Liu@amd.com">
&lt;Monk.Liu@amd.com&gt;</a><br>
<b>Cc:</b> Min, Frank <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:F=
rank.Min@amd.com">
&lt;Frank.Min@amd.com&gt;</a>; Chen, Horace <a class=3D"x_moz-txt-link-rfc2=
396E" href=3D"mailto:Horace.Chen@amd.com">
&lt;Horace.Chen@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: force using sdma to update vm page =
table when mmio is blocked</font>
<div>&nbsp;</div>
</div>
<div>Well NAK.<br>
<br>
Even when we can't R/W HDP registers we need a way to invalidate the HDP or=
 quite a bunch of functions won't work correctly.<br>
<br>
Blocking CPU base page table updates only works around the symptoms, but do=
esn't really solve anything.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<div class=3D"x_x_moz-cite-prefix">Am 20.01.22 um 09:46 schrieb Wang, Yang(=
Kevin):<br>
</div>
<blockquote type=3D"cite">
<p align=3D"Left" style=3D"margin-top: 0px; margin-bottom: 0px;margin-top:0=
px; margin-bottom:0px; font-family:Arial; font-size:10pt; color:#0000FF; ma=
rgin:5pt">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
ping...</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
add <a id=3D"OWAAM160069" class=3D"x_x_P8b7u5KH31KY6Eljcf5yw x_x_mention x_=
x_ms-bgc-nlr x_x_ms-fcl-b" href=3D"mailto:Monk.Liu@amd.com">
@Liu, Monk</a>&nbsp;<a id=3D"OWAAM254265" class=3D"x_x_P8b7u5KH31KY6Eljcf5y=
w x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b" href=3D"mailto:Christian.Koenig@=
amd.com">@Koenig, Christian</a>&nbsp;<a id=3D"OWAAM277931" class=3D"x_x_P8b=
7u5KH31KY6Eljcf5yw x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b" href=3D"mailto:=
Alexander.Deucher@amd.com">@Deucher,
 Alexander</a></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wang, Yang(Kevin)
<a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mailto:KevinYang.Wang@amd.co=
m">&lt;KevinYang.Wang@amd.com&gt;</a><br>
<b>Sent:</b> Wednesday, January 19, 2022 11:16 AM<br>
<b>To:</b> <a class=3D"x_x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx=
@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_x_moz-txt-link-rfc2396E" hr=
ef=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Min, Frank <a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mailto=
:Frank.Min@amd.com">
&lt;Frank.Min@amd.com&gt;</a>; Chen, Horace <a class=3D"x_x_moz-txt-link-rf=
c2396E" href=3D"mailto:Horace.Chen@amd.com">
&lt;Horace.Chen@amd.com&gt;</a>; Wang, Yang(Kevin) <a class=3D"x_x_moz-txt-=
link-rfc2396E" href=3D"mailto:KevinYang.Wang@amd.com">
&lt;KevinYang.Wang@amd.com&gt;</a><br>
<b>Subject:</b> [PATCH] drm/amdgpu: force using sdma to update vm page tabl=
e when mmio is blocked</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">when mmio protection feature is enabled in hyp=
ervisor,<br>
it will cause guest OS can't R/W HDP regiters,<br>
and using cpu to update page table is not working well.<br>
<br>
force using sdma to update page table when mmio is blocked.<br>
<br>
Signed-off-by: Yang Wang <a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mai=
lto:KevinYang.Wang@amd.com">
&lt;KevinYang.Wang@amd.com&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index b23cb463b106..0f86f0b2e183 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
=3D !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_V=
M_USE_CPU_FOR_GFX);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&a=
mp; amdgpu_sriov_vf(adev) &amp;&amp; amdgpu_virt_mmio_blocked(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vm-&gt;use_cpu_for_update =3D false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM =
update mode is %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 vm-&gt;use_cpu_for_update ? &quot;CPU&quot; : &quot;SDMA&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_=
for_update &amp;&amp;<br>
@@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update VM state */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
=3D !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_V=
M_USE_CPU_FOR_COMPUTE);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&a=
mp; amdgpu_sriov_vf(adev) &amp;&amp; amdgpu_virt_mmio_blocked(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vm-&gt;use_cpu_for_update =3D false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM =
update mode is %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 vm-&gt;use_cpu_for_update ? &quot;CPU&quot; : &quot;SDMA&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_=
for_update &amp;&amp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</div>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_CO6PR12MB5473612CFBEC14CB9D6315E0825A9CO6PR12MB5473namp_--
