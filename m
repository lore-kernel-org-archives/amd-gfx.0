Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFA606A32F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=I+34NYZE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1616410E265;
	Wed,  4 Nov 2026 16:33:54 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B2C10E265
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 16:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HM50mUa9c/JFRzfUSXYwkZ5XB/YBufwOTPbxg6yrRDZDb9l0xF5aajsMkjt4Iw6R8tgHA0XBBevY8zKtL4BO1iXLBwGaX2t76RaVat5kY/Ls+nNdk9mA8beXybpxog0gqaUbO6+SPKa0I5iWQ5GhSpulIwr80vjnnKgfUWngCC19avm/wt5C/HmatE4u+0lu+kY2cZoHAzQUfItacF8xUUleR7MgEUWVVHrJpRQD4vxG+qMjpbahnJeJuFkUbSUdsyJNJUYn5dSFv7AyCeTcaYSrdvhCIvfbqfqarvc8tiNflcb8ElJXvFvBr+kw8hPwnlU5MpiDQ0OPiAdX4cNLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d+dRViqSX9qkDUjPPcqrIWexrZqymae41C3ocRSjvQ=;
 b=RixdC6StwauOnROTXAvNKIHSaI7pj/wS6Wjh+jV8WedOC4NBjI3fooOKJWY38AjqefS/jHCBzvxA9BHk+akqwdilSn3wrUYoMy0FMpTAfMXWwSjlXTBiO5ynHOFXoD43DPSn/Pb0t76w5DMmYuOShljd3w7oIziVkTe1jJezIcFaN/o99IaPQ9Y6+bU6m0PJJI9CCWqdZ8mrzbKgIi63RbqAeiaDmIfhb1uhO1fxScL7ZGFMFhrNs8k9taiidAXdCle/j7yzGyR6lpF/Lns9R0kOdjgxCg6YViYe/Sz86Brmp6LYX+PeW5yftGkB9Y/ikHGVBluy2Jeor84dvjKOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d+dRViqSX9qkDUjPPcqrIWexrZqymae41C3ocRSjvQ=;
 b=I+34NYZE73v4yKQ3AyqqXLtqZ8yVWj/sgU14YcZUaKtTLMWIfsGTBH+3DEQgXEgqgVtA8r+X2Zs6XszGavIwkhPt+kCci1/xoJZFymXffHOr0yUr/seGiDAHXaZqqAhMsrh4dU+U+qhE+NjePTWlZwdR7vPzt/b5octKGJ2zmEo=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:33:42 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:33:41 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
Thread-Index: AQHdZ9BSLA5xcHDK5EWJ/SgTc/U/J7caNtKAgADYwBCAANvTgIACGcOigAATgwCAAAl9ng==
Date: Wed, 4 Nov 2026 16:33:41 +0000
Message-ID: <SJ1PR12MB61219844F6FC245149306C9D80682@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-2-Chenglei.Xie@amd.com>
 <3a518d91-c6ef-4fbf-8525-5a762d465ccb@amd.com>
 <SJ1PR12MB6121D39D1B80B22A317CD00B806A2@SJ1PR12MB6121.namprd12.prod.outlook.com>
 <4a704ee7-01ef-40e0-8256-d0321914d27a@amd.com>
 <SJ1PR12MB612191850F1E0392C85225F880682@SJ1PR12MB6121.namprd12.prod.outlook.com>
 <94f93ec7-a584-4a98-9c1d-a23056b1af43@amd.com>
In-Reply-To: <94f93ec7-a584-4a98-9c1d-a23056b1af43@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T16:33:40.004Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|BL4PR12MB9479:EE_
x-ms-office365-filtering-correlation-id: 65f0a4bc-7933-4f1c-ec68-08df3a91630d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|8096899003|6133799003|22082099003|18002099003|10067099003|261102123227099003|38070700021|4143699003|11063799006|5023799004|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261028144727099003|56012099006|261009223027099003|261021121427099003;
x-microsoft-antispam-message-info: LcxC7o9UwzRFiEayl//kRh3ob637hkKIhj/8OOxv8clqKKL3xLGDDlJPvUKGUJNTe9LN8jSSv6utzpf3+WS9i/atQ7P/V4ylFVLNaJtKyde81UDt9iKZvbhf/BimRxmYLXplBYodLNNbn2eK278JVaauLbUZ4G+Eyo/NHGATdaP8qLL6Xiq9W/brBZHcaFDso0eZcpZlXWBn/a6/ltniPhBKjxrJBziZS77yBqlBlguszaZ9ZVkEj2nVIhQAj5IHgF8DW528lCITORPTRXq83RKkCsM3iz+EAyKx/+H7LAI0MxVZ0hrSG+BjDF9t0uekQFLK8tGvqSpp80cl7+5cRMMs38jXXlTis4k41Ur6zFuxruVMSLoVnCIJ8p9VBhL0V473XiV53JUOqkjj0uRrb12R0q04YxHS9W4ZfqFYBM+6JBzct2vFkdfjz42YnjGR5Gk0Pv3AeGK200MUKhJO0Sg9dbsaGfGzCaL3aC0QONmbTdz4S4wDzXkzZD+umMf+/jlphlbm9Ep2KIthUafZWE02moO0sgkZzgex0aaBGrIsT3Pz+ck0z12BYHMNVyko/zMndE+EIUKvCtReEoySJybE7FFMWHSXlHaxVv9hrrnxzjHDZXSQwQPEF/hHRfBchGXLGtfK17TBU3zeU9r5UgsCo0jBAgiE8t1j/CmXeMCHexJRezKsRtKL1xzJSgKzUOnuxsCaP486wOy/FwhzDj4Ex1lfIpDkwMCTEgjjaZI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(8096899003)(6133799003)(22082099003)(18002099003)(10067099003)(261102123227099003)(38070700021)(4143699003)(11063799006)(5023799004)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(56012099006)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AVjNAMwvtxTP5EOU5vAaXKUqxKeCND93AFiFP0ulZtbr5HOaXqzGCmfOLzer?=
 =?us-ascii?Q?Mrjuy1RKwrDjrSpkFbwK6LGIO9DD0FqNwn8cDz7kgo16b1ynSNA5ziQHKgSO?=
 =?us-ascii?Q?37aRplqMsEFA0q+jrMZaPh2mUGJ6TkbqavyWD7LLhiZX8NzaMCvIv2z2Jjku?=
 =?us-ascii?Q?UaRi8sAQlcemskzc0VboBrVIi6eE12iJj9aVElBj3kRh5vDlJmNVEH1yCrQM?=
 =?us-ascii?Q?kqZFNauym599rEZA5FDBxCAef9aqE4gKzSNolWrjzF4EWvDZ9WEPRV0uD4wO?=
 =?us-ascii?Q?aBVDZfrNB1f/ty2Ks7JvaKqMFPvAuXpqEAbP1oAj3JkJGq9J7QWichBYqHi0?=
 =?us-ascii?Q?vmjh3UMW2b5ReCUGL7YDl4l7UDv9tI1zTRfYMNenjVNz/hzJWyyE0ru5Lbzc?=
 =?us-ascii?Q?Sh9Ru1/5NCW+uHd5h2TVXzqEqP2OGGK99cjvWpaTRTo5dGFGzevINMjrzxPB?=
 =?us-ascii?Q?7/ujv09TOzAZeWTPYgLSEo/o5b68DidVjy5DJg+euzCxGV++wbeKywwCggSZ?=
 =?us-ascii?Q?61PE4jS3aNT4L4U9732qf3j2qN+nOwqkGJnDC3nfTqKNyy45//+l7xsbTRmT?=
 =?us-ascii?Q?6HXP5w6+oC/brrrniA/h5IcaLimaERH0bmrekDzUJuT4KncHEB1voEYGgxjL?=
 =?us-ascii?Q?OC8jFEdQS1QYl5f8r4MntI+mTw+xhaChAU6Lph/8FoHcFmQPS3eg91jOWRSj?=
 =?us-ascii?Q?yu+aN0VMQWODneTVSE43tWqU9Tr3u5hgEBpvVt8bCvfGmwpDNNz44BjKXOtb?=
 =?us-ascii?Q?uM9ajM1WbD7ZRsUZWvsKgxis/VJWItQ+bxRIYVOEByUSZQlR9fgPcjZxzX7P?=
 =?us-ascii?Q?SdewtX/TUa9fPITtXny0wHznW86OTkV6lbvDVkhL/2B5jaixXRa9+73v3P16?=
 =?us-ascii?Q?Z00l0T1mCh+TnGvs0nzaweuZlTENsMfLVISmT7R7Iyyk2wt3plMh7E/2Dx8G?=
 =?us-ascii?Q?qrQSOlMuRpIesjKtN9cMyUnza+7G8Bca3r0jX1QFnQIPDZ0iDc8IJCXsnSlc?=
 =?us-ascii?Q?UFMgnXBtVo4epU508CTKtd5q11y1DZyMl8QOkMjtCjJn4Ncs5a3sZgsiAfgX?=
 =?us-ascii?Q?W1OWhz2LHAlTNrUd5gXhP96CLFDvCoG/RoG00ZQwDdpJj+OvAQhsPhZas8tM?=
 =?us-ascii?Q?c0OaBArjRS+psDQ9nocEcZkaZcyeXUTlF74uENP1FuHazLUcnNRc5DKCtWXE?=
 =?us-ascii?Q?PQHloBtqeUiOPLn4EoO/i1xkDp5wnJJxpqbx/m7Y4LBkRLP9+KpEkbcwLUy2?=
 =?us-ascii?Q?O2/4ahRJ6M+o9+B6YkIZsO/E3VrrhNztePqQKXRDN1I9NomyXtVsdR/x9cOJ?=
 =?us-ascii?Q?hEqR+I1CInkHOoN7y73Zw4gIOqpcg0hMPTFZb/c/jeT6ymr3ktEMzOB5HiVU?=
 =?us-ascii?Q?4q5s3Fd0+d5OIy9sgLlVviZ8L7KBplAU6ml09q2GbfkGkheJmm9R+twWjy/4?=
 =?us-ascii?Q?/SZbF/9mFiJ+Lc5A/TM8MXEJwROFuBWNG9pGFDzGbfyoQpLKKIAaDVUQWbLb?=
 =?us-ascii?Q?nmpHu/xg6wTSdnqf82t81eI6EQvmmhI84AlYZTI0UVIRB0w6s9LeOT2280JL?=
 =?us-ascii?Q?kbX18RpPQPNeZ3PkNoVRW0zGubIpRTcMp9QzRpJB1uI2iThxKZgxVkWHA4Tr?=
 =?us-ascii?Q?UdWR3InPWYn5EK/COHycNq+rMgPGV/WYYs65qsv8EOe7l69DVjCZ6krxBEwc?=
 =?us-ascii?Q?o84wItdwy8RABWSC4+o4NBOKXE3IlgZaC5TnXlnc6J37A7PO?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB61219844F6FC245149306C9D80682SJ1PR12MB6121namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f0a4bc-7933-4f1c-ec68-08df3a91630d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 16:33:41.5991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39KUi+1LuElPhgwUIwOWD9wovBATzre2J4FBtlx4829jJER0P111pp8c5GcW9lIDMiKT/7Y7A0NC9XivNWRKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_SJ1PR12MB61219844F6FC245149306C9D80682SJ1PR12MB6121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

>If deactivating is harmless in early access also (looks so to me),
>suggest to make the behavior the same in both cases for the sake of
>consistency.

>Thanks,
>Lijo

Deactivate is harmless on the early access path too. The only
catch is the err_release_full_gpu label also releases full GPU access, gate=
d on
early_full_gpu_access, which is true there, so a plain goto would release
access the failed request never acquired. To ensure the consistancy,
I made a v3 patch to gate the release on full_access_held flag
set after each successful acquire, and route both
request failures through the label. So the two cases behave the same now.

Thanks,
Chenglei
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 4, 2026 10:50 AM
To: Xie, Chenglei <Chenglei.Xie@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang <Zhigang.Luo=
@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM aper=
ture is missing



On 04-Nov-26 8:44 PM, Xie, Chenglei wrote:
> AMD General
>
> On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:
>
>     AMD General
>
>     +err_release_full_gpu:
>     + if (amdgpu_sriov_vf(adev)) {
>     + /*
>     + * Release the access the host is waiting on so it finishes the
>     + * handshake instead of timing out and FLR'ing the VF.
>     + /
>     + if (early_full_gpu_access)
>     + amdgpu_virt_release_full_gpu(adev, true);
>     +
>     + /*
>     + * Mark the VF inactive so the later fini path does not send a
>     + * request the host will never answer.
>     + /
>     + amdgpu_virt_deactivate(adev);
>
>      >Shouldn't this be called when amdgpu_virt_request_full_gpu fails fo=
r
>      >early_full_gpu_access case also?
>      >Thanks,
>      >Lijo
>
>     No, it should not be called. If amdgpu_virt_request_full_gpu fails,
>     the VF holds no access as the acquire handshake never completed.
>     There is nothing to release and RUNTIME was never set,
>     so the amdgpu_virt_deactivate() has nothing to clear.
>     Jumping to err_release_full_gpu would send a release for access that =
is
>     never granted.
>
>  > In that case, this code needs to be changed to just return immediately=
.
>  > if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>  > r =3D amdgpu_virt_request_full_gpu(adev, true);
>  > if (r)
>  > - return r;
>  > + goto err_release_full_gpu;
>
>  >Thanks,
>  >Lijo
>
> No, the goto is needed here because we need the amdgpu_virt_deactivate()
> to prevent REQ_GPU_FINI to be sent inside amdgpu_device_fini_hw(). In
> amdgpu_driver_unload_kms(),
>
>     void amdgpu_driver_unload_kms(struct drm_device dev)
>     {
>     struct amdgpu_device adev =3D drm_to_adev(dev);
>     if (adev =3D=3D NULL || *!adev->num_ip_blocks*)
>     return;
>     amdgpu_unregister_gpu_instance(adev);
>     i f (adev->rmmio =3D=3D NULL)
>     return;
>     if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_UNLOAD))
>     drm_warn(dev, "smart shift update failed
>     ");
>     amdgpu_acpi_fini(adev);
>     amdgpu_device_fini_hw(adev);
>     }
>
> it checks if adev->num_ip_blocks is non-zero to proceed with the
> device_fini.
> In the early full access case, it runs before IP discovery while
> num_ip_blocks is still 0.
> So the amdgpu_driver_unload_kms() returns before the fini. But here it
> already passed
> the ip discovery set, so the num_ip_blocks>0 and fini will be executed.
> Also, release_full_gpu is correctly skipped since early_full_gpu_access
> is false in this case.
> ]

If deactivating is harmless in early access also (looks so to me),
suggest to make the behavior the same in both cases for the sake of
consistency.

Thanks,
Lijo
> Thanks,
> Chenglei
>
>
>
>
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Tuesday, November 3, 2026 1:35 AM
> *To:* Xie, Chenglei <Chenglei.Xie@amd.com>; amd-
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang
> <Zhigang.Luo@amd.com>
> *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
> aperture is missing
>
>
> On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:
>> AMD General
>>
>>     +err_release_full_gpu:
>>     + if (amdgpu_sriov_vf(adev)) {
>>     + /*
>>     + * Release the access the host is waiting on so it finishes the
>>     + * handshake instead of timing out and FLR'ing the VF.
>>     + /
>>     + if (early_full_gpu_access)
>>     + amdgpu_virt_release_full_gpu(adev, true);
>>     +
>>     + /*
>>     + * Mark the VF inactive so the later fini path does not send a
>>     + * request the host will never answer.
>>     + /
>>     + amdgpu_virt_deactivate(adev);
>>
>>>Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>>>early_full_gpu_access case also?
>>>Thanks,
>>>Lijo
>>
>> No, it should not be called. If amdgpu_virt_request_full_gpu fails,
>> the VF holds no access as the acquire handshake never completed.
>> There is nothing to release and RUNTIME was never set,
>> so the amdgpu_virt_deactivate() has nothing to clear.
>> Jumping to err_release_full_gpu would send a release for access that is
>> never granted.
>>
>
> In that case, this code needs to be changed to just return immediately.
>
>   >        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>   >                r =3D amdgpu_virt_request_full_gpu(adev, true);
>   >                if (r)
>   > -                     return r;
>   > +                     goto err_release_full_gpu;
>
>
> Thanks,
> Lijo
>
>> Thanks,
>> Chenglei
>>
>>
>> ------------------------------------------------------------------------
>> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
>> *Sent:* Sunday, November 1, 2026 11:32 PM
>> *To:* Xie, Chenglei <Chenglei.Xie@amd.com>; amd-
>> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang
>> <Zhigang.Luo@amd.com>
>> *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
>> aperture is missing
>>
>>
>> On 29-Oct-26 11:36 PM, Chenglei Xie wrote:
>>> An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACPI
>>> SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat()
>>> returns -ENOENT, which the early init IP loop treats as the GMC block
>>> being absent. Init keeps going and dies later with a confusing -ENOMEM
>>> instead of the real cause.
>>>
>>> Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the
>>> point where the aperture is actually missing.
>>>
>>> On a legacy host the VF already holds exclusive GPU access at this poin=
t,
>>> and the early init error paths returned directly without releasing it, =
so
>>> the host timed out and FLR'd the VF. Route these failures through a new
>>> err_release_full_gpu label that releases the access the host is waiting=
 on.
>>>
>>> Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and dro=
p
>>> adev->virt.ops, and call it from the same label, so the later fini path
>>> does not send a REQ_GPU_FINI that the host will never answer.
>>>
>>> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>>> ---
>>> v2: Move the runtime cap and virt ops clearing into a new
>>>      amdgpu_virt_deactivate() helper and call it from the label. Drop t=
he
>>>      redundant SRAT error log already emitted by
>>>      amdgpu_acpi_find_gpu_memory_in_srat().
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++++++-----=
-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 +++-
>>>   4 files changed, 55 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
>>> index 3ced5c18daaa..3b6a3d86348c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>>>
>>>                r =3D amdgpu_virt_init_critical_region(adev);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>        }
>>>
>>>        switch (adev->asic_type) {
>>> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>>>                adev->family =3D AMDGPU_FAMILY_SI;
>>>                r =3D si_set_ip_blocks(adev);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>                break;
>>>   #endif
>>>   #ifdef CONFIG_DRM_AMDGPU_CIK
>>> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>>>
>>>                r =3D cik_set_ip_blocks(adev);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>                break;
>>>   #endif
>>>        case CHIP_TOPAZ:
>>> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct a=
mdgpu_device *adev)
>>>
>>>                r =3D vi_set_ip_blocks(adev);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>                break;
>>>        default:
>>>                r =3D amdgpu_discovery_set_ip_blocks(adev);
>>>                if (r) {
>>>                        adev->num_ip_blocks =3D 0;
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>                }
>>>                break;
>>>        }
>>> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>>>        if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, =
3) &&
>>>            !amdgpu_device_get_rev_id(adev)) {
>>>                dev_err(adev->dev, "Unsupported A0 hardware\n");
>>> -             return -ENODEV; /* device unsupported - no device error *=
/
>>> +             r =3D -ENODEV;    /* device unsupported - no device error=
 */
>>> +             goto err_release_full_gpu;
>>>        }
>>>
>>>        if (amdgpu_has_atpx() &&
>>> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>>>                if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK=
_TYPE_COMMON) {
>>>                        r =3D amdgpu_device_parse_gpu_info_fw(adev);
>>>                        if (r)
>>> -                             return r;
>>> +                             goto err_release_full_gpu;
>>>
>>>                        bios_flags =3D amdgpu_device_get_vbios_flags(ade=
v);
>>>                        skip_bios =3D !!(bios_flags & AMDGPU_VBIOS_SKIP)=
;
>>> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)
>>>                        if (!skip_bios) {
>>>                                bool optional =3D
>>>                                        !!(bios_flags & AMDGPU_VBIOS_OPT=
IONAL);
>>> -                             if (!amdgpu_get_bios(adev) && !optional)
>>> -                                     return -EINVAL;
>>> +                             if (!amdgpu_get_bios(adev) && !optional) =
{
>>> +                                     r =3D -EINVAL;
>>> +                                     goto err_release_full_gpu;
>>> +                             }
>>>
>>>                                if (optional && !adev->bios)
>>>                                        dev_info(
>>> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>>>                                                        adev,
>>>                                                        AMDGIM_ERROR_VF_=
ATOMBIOS_INIT_FAIL,
>>>                                                        0, 0);
>>> -                                             return r;
>>> +                                             goto err_release_full_gpu=
;
>>>                                        }
>>>                                }
>>>                        }
>>> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct a=
mdgpu_device *adev)
>>>
>>>                }
>>>        }
>>> -     if (!total)
>>> -             return -ENODEV;
>>> +     if (!total) {
>>> +             r =3D -ENODEV;
>>> +             goto err_release_full_gpu;
>>> +     }
>>>
>>>        /* Request full GPU access only for the remaining SR-IOV init wo=
rk. */
>>>        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>                r =3D amdgpu_virt_request_full_gpu(adev, true);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>        }
>>>
>>>        if (adev->gmc.xgmi.supported)
>>> @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)
>>>        amdgpu_smu_early_init(adev);
>>>
>>>        return 0;
>>> +
>>> +err_release_full_gpu:
>>> +     if (amdgpu_sriov_vf(adev)) {
>>> +             /*
>>> +              * Release the access the host is waiting on so it finish=
es the
>>> +              * handshake instead of timing out and FLR'ing the VF.
>>> +              */
>>> +             if (early_full_gpu_access)
>>> +                     amdgpu_virt_release_full_gpu(adev, true);
>>> +
>>> +             /*
>>> +              * Mark the VF inactive so the later fini path does not s=
end a
>>> +              * request the host will never answer.
>>> +              */
>>> +             amdgpu_virt_deactivate(adev);
>>
>> Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>> early_full_gpu_access case also?
>>
>> Thanks,
>> Lijo
>>> +     }
>>> +
>>> +     return r;
>>>   }
>>>
>>>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev=
)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c
>>> index 576a818db522..a4dd0299fe11 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_dev=
ice *adev, bool init)
>>>        return 0;
>>>   }
>>>
>>> +/*
>>> + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed i=
nit
>>> + *
>>> + * Clear the runtime capability and drop the virt ops so the teardown =
path
>>> + * does not issue host handshakes the host will never answer.
>>> + */
>>> +void amdgpu_virt_deactivate(struct amdgpu_device *adev)
>>> +{
>>> +     adev->virt.caps &=3D ~AMDGPU_SRIOV_CAPS_RUNTIME;
>>> +     adev->virt.ops =3D NULL;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_virt_reset_gpu() - reset gpu
>>>    * @adev:   amdgpu device.
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.h
>>> index 3971bcc1ed11..3520af170278 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device =
*adev);
>>>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>>>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool ini=
t);
>>>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool ini=
t);
>>> +void amdgpu_virt_deactivate(struct amdgpu_device *adev);
>>>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>>>   void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
>>>   int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v12_0.c
>>> index cd276a138e10..3bb13cfed92f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_b=
lock *ip_block)
>>>
>>>                r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_ba=
se,
>>>                                                        &aper_size);
>>> +             /*
>>> +              * An SPM VF has no FB BAR0 and cannot init without the H=
BM
>>> +              * aperture from the SRAT. Abort this GPU probe instead o=
f
>>> +              * limping on as if the GMC block were absent.
>>> +              */
>>>                if (r)
>>> -                     return r;
>>> +                     return -ENODEV;
>>>
>>>                adev->gmc.aper_base =3D aper_base;
>>>                adev->gmc.aper_size =3D aper_size;
>>
>


--_000_SJ1PR12MB61219844F6FC245149306C9D80682SJ1PR12MB6121namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"min-height: 18px;">
<div class=3D"elementToProof" style=3D"min-height: 18px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&gt;If deactivating is harmless in early access also (looks so to me),<br>
&gt;suggest to make the behavior the same in both cases for the sake of<br>
&gt;consistency.<br>
<br>
&gt;Thanks,<br>
&gt;Lijo</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Deactivate is harmless on the early access path too. The only</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 18px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0,=
 0);">
<span style=3D"font-size: 12pt;">catch is the </span><span style=3D"font-si=
ze: 11pt;">err_release_full_gpu
</span><span style=3D"font-size: 12pt;">label also releases full GPU access=
, gated on</span></div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 18px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
early_full_gpu_access, which is true there, so a plain goto would release</=
div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 18px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
access the failed request never acquired. To ensure the consistancy,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
I made a v3 patch to gate the release on full_access_held flag</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
set after each successful acquire, and route both</div>
</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 18px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0,=
 0);">
<span style=3D"font-size: 12pt;">request failures through the </span><span =
style=3D"font-size: 11pt;"></span><span style=3D"font-size: 12pt;">label. S=
o the two cases behave the same now.</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 10px; padding-left: 10px; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Chenglei</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 4, 2026 10:50 AM<br>
<b>To:</b> Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Luo, Zhigang=
 &lt;Zhigang.Luo@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the H=
BM aperture is missing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 04-Nov-26 8:44 PM, Xie, Chenglei wrote:<br>
&gt; AMD General<br>
&gt; <br>
&gt; On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; AMD General<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; +err_release_full_gpu:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + if (amdgpu_sriov_vf(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * Release the access the host is waiting on =
so it finishes the<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * handshake instead of timing out and FLR'in=
g the VF.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + if (early_full_gpu_access)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + amdgpu_virt_release_full_gpu(adev, true);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * Mark the VF inactive so the later fini pat=
h does not send a<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * request the host will never answer.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + amdgpu_virt_deactivate(adev);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Shouldn't this be called when amdgpu=
_virt_request_full_gpu fails for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;early_full_gpu_access case also?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Thanks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Lijo<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; No, it should not be called. If amdgpu_virt_re=
quest_full_gpu fails,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; the VF holds no access as the acquire handshak=
e never completed.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; There is nothing to release and RUNTIME was ne=
ver set,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; so the amdgpu_virt_deactivate() has nothing to=
 clear.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Jumping to err_release_full_gpu would send a r=
elease for access that is<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; never granted.<br>
&gt; <br>
&gt;&nbsp; &gt; In that case, this code needs to be changed to just return =
immediately.<br>
&gt;&nbsp; &gt; if (amdgpu_sriov_vf(adev) &amp;&amp; !early_full_gpu_access=
) {<br>
&gt;&nbsp; &gt; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&nbsp; &gt; if (r)<br>
&gt;&nbsp; &gt; - return r;<br>
&gt;&nbsp; &gt; + goto err_release_full_gpu;<br>
&gt; <br>
&gt;&nbsp; &gt;Thanks,<br>
&gt;&nbsp; &gt;Lijo<br>
&gt; <br>
&gt; No, the goto is needed here because we need the amdgpu_virt_deactivate=
()<br>
&gt; to prevent REQ_GPU_FINI to be sent inside amdgpu_device_fini_hw(). In =
<br>
&gt; amdgpu_driver_unload_kms(),<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; void amdgpu_driver_unload_kms(struct drm_devic=
e dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device adev =3D drm_to_adev(dev)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (adev =3D=3D NULL || *!adev-&gt;num_ip_bloc=
ks*)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_unregister_gpu_instance(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; i f (adev-&gt;rmmio =3D=3D NULL)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_smart_shift_update(adev, AMDGP=
U_SS_DRV_UNLOAD))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; drm_warn(dev, &quot;smart shift update failed<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_acpi_fini(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_fini_hw(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; it checks if adev-&gt;num_ip_blocks is non-zero to proceed with the <b=
r>
&gt; device_fini.<br>
&gt; In the early full access case, it runs before IP discovery while <br>
&gt; num_ip_blocks is still 0.<br>
&gt; So the amdgpu_driver_unload_kms() returns before the fini. But here it=
 <br>
&gt; already passed<br>
&gt; the ip discovery set, so the num_ip_blocks&gt;0 and fini will be execu=
ted.<br>
&gt; Also, release_full_gpu is correctly skipped since early_full_gpu_acces=
s <br>
&gt; is false in this case.<br>
&gt; ]<br>
<br>
If deactivating is harmless in early access also (looks so to me), <br>
suggest to make the behavior the same in both cases for the sake of <br>
consistency.<br>
<br>
Thanks,<br>
Lijo<br>
&gt; Thanks,<br>
&gt; Chenglei<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; *Sent:* Tuesday, November 3, 2026 1:35 AM<br>
&gt; *To:* Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; amd- <br>
&gt; gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc:* Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Luo, Zhigang=
 <br>
&gt; &lt;Zhigang.Luo@amd.com&gt;<br>
&gt; *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the H=
BM <br>
&gt; aperture is missing<br>
&gt; <br>
&gt; <br>
&gt; On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:<br>
&gt;&gt; AMD General<br>
&gt;&gt; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; +err_release_full_gpu:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + if (amdgpu_sriov_vf(adev)) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /*<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * Release the access the host is waiting=
 on so it finishes the<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * handshake instead of timing out and FL=
R'ing the VF.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + if (early_full_gpu_access)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + amdgpu_virt_release_full_gpu(adev, true)=
;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; +<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /*<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * Mark the VF inactive so the later fini=
 path does not send a<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * request the host will never answer.<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; + amdgpu_virt_deactivate(adev);<br>
&gt;&gt; <br>
&gt;&gt;&gt;Shouldn't this be called when amdgpu_virt_request_full_gpu fail=
s for<br>
&gt;&gt;&gt;early_full_gpu_access case also?<br>
&gt;&gt;&gt;Thanks,<br>
&gt;&gt;&gt;Lijo<br>
&gt;&gt; <br>
&gt;&gt; No, it should not be called. If amdgpu_virt_request_full_gpu fails=
,<br>
&gt;&gt; the VF holds no access as the acquire handshake never completed.<b=
r>
&gt;&gt; There is nothing to release and RUNTIME was never set,<br>
&gt;&gt; so the amdgpu_virt_deactivate() has nothing to clear.<br>
&gt;&gt; Jumping to err_release_full_gpu would send a release for access th=
at is <br>
&gt;&gt; never granted.<br>
&gt;&gt; <br>
&gt; <br>
&gt; In that case, this code needs to be changed to just return immediately=
.<br>
&gt; <br>
&gt;&nbsp; &nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_=
sriov_vf(adev) &amp;&amp; !early_full_gpu_access) {<br>
&gt;&nbsp; &nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(ade=
v, true);<br>
&gt;&nbsp; &nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp; &nbsp;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 r;<br>
&gt;&nbsp; &nbsp;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto e=
rr_release_full_gpu;<br>
&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt; <br>
&gt;&gt; Thanks,<br>
&gt;&gt; Chenglei<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; ------------------------------------------------------------------=
------<br>
&gt;&gt; *From:* Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt;&gt; *Sent:* Sunday, November 1, 2026 11:32 PM<br>
&gt;&gt; *To:* Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; amd- <br>
&gt;&gt; gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br=
>
&gt;&gt; *Cc:* Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Luo, Zhi=
gang <br>
&gt;&gt; &lt;Zhigang.Luo@amd.com&gt;<br>
&gt;&gt; *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when t=
he HBM <br>
&gt;&gt; aperture is missing<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; On 29-Oct-26 11:36 PM, Chenglei Xie wrote:<br>
&gt;&gt;&gt; An SPM backed VF has no FB BAR0 and gets its HBM aperture from=
 the ACPI<br>
&gt;&gt;&gt; SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_=
in_srat()<br>
&gt;&gt;&gt; returns -ENOENT, which the early init IP loop treats as the GM=
C block<br>
&gt;&gt;&gt; being absent. Init keeps going and dies later with a confusing=
 -ENOMEM<br>
&gt;&gt;&gt; instead of the real cause.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Return -ENODEV from gmc_v12_0_early_init() so the probe aborts=
 at the<br>
&gt;&gt;&gt; point where the aperture is actually missing.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; On a legacy host the VF already holds exclusive GPU access at =
this point,<br>
&gt;&gt;&gt; and the early init error paths returned directly without relea=
sing it, so<br>
&gt;&gt;&gt; the host timed out and FLR'd the VF. Route these failures thro=
ugh a new<br>
&gt;&gt;&gt; err_release_full_gpu label that releases the access the host i=
s waiting on.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIM=
E and drop<br>
&gt;&gt;&gt; adev-&gt;virt.ops, and call it from the same label, so the lat=
er fini path<br>
&gt;&gt;&gt; does not send a REQ_GPU_FINI that the host will never answer.<=
br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Signed-off-by: Chenglei Xie &lt;Chenglei.Xie@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; v2: Move the runtime cap and virt ops clearing into a new<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_deactivate() helper =
and call it from the label. Drop the<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; redundant SRAT error log already=
 emitted by<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_acpi_find_gpu_memory_in_s=
rat().<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++=
++++++++++++++------<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbs=
p; | 12 ++++++<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbs=
p; |&nbsp; 1 +<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 7 +++-<br>
&gt;&gt;&gt;&nbsp;&nbsp; 4 files changed, 55 insertions(+), 14 deletions(-)=
<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; index 3ced5c18daaa..3b6a3d86348c 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_init_critical_region(adev);<b=
r>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_releas=
e_full_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asi=
c_type) {<br>
&gt;&gt;&gt; @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;family =3D AMDGPU_FAMILY_SI;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D si_set_ip_blocks(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_releas=
e_full_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&nbsp;&nbsp; #endif<br>
&gt;&gt;&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMDGPU_CIK<br>
&gt;&gt;&gt; @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D cik_set_ip_blocks(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_releas=
e_full_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&nbsp;&nbsp; #endif<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TOPAZ:<br>
&gt;&gt;&gt; @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init=
(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vi_set_ip_blocks(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_releas=
e_full_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_ip_blocks(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 adev-&gt;num_ip_blocks =3D 0;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_releas=
e_full_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versio=
n(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) &amp;&amp;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; !amdgpu_device_get_rev_id(adev)) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Unsupported A0 hard=
ware\n&quot;);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return -ENODEV; /* device unsupported - no device error */<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; r =3D -ENODEV;&nbsp;&nbsp;&nbsp; /* device unsupported - no dev=
ice error */<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; goto err_release_full_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_has_atpx(=
) &amp;&amp;<br>
&gt;&gt;&gt; @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=
=3D AMD_IP_BLOCK_TYPE_COMMON) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 r =3D amdgpu_device_parse_gpu_info_fw(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (r)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 bios_flags =3D amdgpu_device_get_vbios_flags(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 skip_bios =3D !!(bios_flags &amp; AMDGPU_VBIOS_SKIP);<br>
&gt;&gt;&gt; @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(=
struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (!skip_bios) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool optional =3D<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; !!(bios_flags &amp; AMDGPU_VBIOS_OPTIONAL);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(adev) &amp;&amp; !opt=
ional)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -EINVAL;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(adev) &amp;&amp; !opt=
ional) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; r =3D -EINVAL;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; goto err_release_full_gpu;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optional &amp;&amp; !a=
dev-&gt;bios)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(<br>
&gt;&gt;&gt; @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_ERROR_VF_ATOMBIOS_INIT_FA=
IL,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, 0);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full=
_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 }<br>
&gt;&gt;&gt; @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init=
(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!total)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return -ENODEV;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!total) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; r =3D -ENODEV;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; goto err_release_full_gpu;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Request full GPU =
access only for the remaining SR-IOV init work. */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(=
adev) &amp;&amp; !early_full_gpu_access) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);=
<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_releas=
e_full_gpu;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgm=
i.supported)<br>
&gt;&gt;&gt; @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(=
struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_smu_early_ini=
t(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +err_release_full_gpu:<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /*<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; * Release the access the host is waiting on so it finishe=
s the<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; * handshake instead of timing out and FLR'ing the VF.<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (early_full_gpu_access)<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_rel=
ease_full_gpu(adev, true);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /*<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; * Mark the VF inactive so the later fini path does not se=
nd a<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; * request the host will never answer.<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; amdgpu_virt_deactivate(adev);<br>
&gt;&gt; <br>
&gt;&gt; Shouldn't this be called when amdgpu_virt_request_full_gpu fails f=
or<br>
&gt;&gt; early_full_gpu_access case also?<br>
&gt;&gt; <br>
&gt;&gt; Thanks,<br>
&gt;&gt; Lijo<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp; static int amdgpu_device_ip_hw_init_phase1(struct =
amdgpu_device *adev)<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt;&gt; index 576a818db522..a4dd0299fe11 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt;&gt; @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct a=
mdgpu_device *adev, bool init)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt; + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a=
 failed init<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Clear the runtime capability and drop the virt ops so the =
teardown path<br>
&gt;&gt;&gt; + * does not issue host handshakes the host will never answer.=
<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +void amdgpu_virt_deactivate(struct amdgpu_device *adev)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.caps &amp;=3D ~AMDGPU_=
SRIOV_CAPS_RUNTIME;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops =3D NULL;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_virt_reset_gpu() - reset gpu<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; * @adev:&nbsp;&nbsp; amdgpu device.<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt;&gt; index 3971bcc1ed11..3520af170278 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt;&gt; @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgp=
u_device *adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp; void amdgpu_virt_init_setting(struct amdgpu_device=
 *adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp; int amdgpu_virt_request_full_gpu(struct amdgpu_dev=
ice *adev, bool init);<br>
&gt;&gt;&gt;&nbsp;&nbsp; int amdgpu_virt_release_full_gpu(struct amdgpu_dev=
ice *adev, bool init);<br>
&gt;&gt;&gt; +void amdgpu_virt_deactivate(struct amdgpu_device *adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp; int amdgpu_virt_reset_gpu(struct amdgpu_device *ad=
ev);<br>
&gt;&gt;&gt;&nbsp;&nbsp; void amdgpu_virt_request_init_data(struct amdgpu_d=
evice *adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp; int amdgpu_virt_ptl_request(struct amdgpu_device *=
adev, u32 req_code,<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/=
gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt;&gt;&gt; index cd276a138e10..3bb13cfed92f 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt;&gt;&gt; @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct am=
dgpu_ip_block *ip_block)<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev,=
 &amp;aper_base,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aper_size);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /*<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; * An SPM VF has no FB BAR0 and cannot init without the HB=
M<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; * aperture from the SRAT. Abort this GPU probe instead of=
<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; * limping on as if the GMC block were absent.<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;=
<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D aper_base;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D aper_size;<br>
&gt;&gt; <br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ1PR12MB61219844F6FC245149306C9D80682SJ1PR12MB6121namp_--
