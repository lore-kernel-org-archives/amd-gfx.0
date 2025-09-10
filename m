Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23862CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 01:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADEB910E821;
	Wed, 10 Sep 2025 01:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wYHE88wr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEAD10E34F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 01:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsEoIYsYv4rRP6hQrIeVQDB7z/pkMklBQARQ7zwtu9bqYKGVeCW6ANNobFgswffxUwQ9oVqpEaUjQOMziLCXpk37zoLjwR2dPDQhp5LoH1qWfzFn1rcW7uNBN3kdaEli5n6mRNgZPpWHhW/19JayBH2sa55o0A8CtI1vmqzgOs5r6XwRCLEx72fcK15p2f++tlwSpwkAEFfXDopzE6euft2fS6n1fjL6I/EC4twfWTgdm7gN8USMlAOrBKtO85zK1j5AonvWgc9ljL5WMK3UchLLrBTkMI08qmlc4+/JlzQyHHkHVQxtK82usw8v3NWsJRw18QNeNrQWmjEzXbOB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTFZG3vg1eWATjxt8TYFsNS4hQq93XgLeb5mH/oWicI=;
 b=Xzua/N3BArVHwQ0s6IUXr+Ef3b+jaBRPSaeDhqKvlwclrEK9FBfem1uYQGYPkfeEl7RxIACUQqCTVzqLNy+E7BCiA+FtyVpF1vM5/gDUPNVL600UpdsFQTzVGKLDPWpboRBc6kjHucVVKDwIuM8nD8OFebHnkDTWFLNIlB237tpG0eMIhnOsjcDdQLX1voRi0umyB4M7tVAdnCSSH99iBg4wUGcpTNgln260fvHuZ4nBmiqjvGlVfjOiXxtPTHBC9sDnSziHesIYNB29jGBtWgZds3xB8T8XcsCRT14yNy4AZejGwPTZIDXDz6zAaXWoTclr1FiLHirmdKVynzN/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTFZG3vg1eWATjxt8TYFsNS4hQq93XgLeb5mH/oWicI=;
 b=wYHE88wrYE2eF4D+TpybbN3Y2cAdpOpK1M/SV30vWzlX9ZKOKtu7Wzge+z836eWKCpDr7rrgHu+AEN2anUk5M9Iqm6MUCd9a9V4i02ThSSIgcn0DN9p41gnuVmBrV2nFG5x/Q9lXL7vbrFv5VGdUQyxmf+erxLMNAlG7mvRFrhs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 01:45:24 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 01:45:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
Thread-Topic: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
Thread-Index: AQHcIGn1khhrH1c5f0qJu9TklhsZHLSLqDxQ
Date: Wed, 10 Sep 2025 01:45:24 +0000
Message-ID: <DS7PR12MB600542F4CF8B3D69A06EB2C6FB0EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250908024021.1857440-1-Prike.Liang@amd.com>
In-Reply-To: <20250908024021.1857440-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-10T01:45:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB5939:EE_
x-ms-office365-filtering-correlation-id: 198311c0-d13c-42c1-4eb9-08ddf00bb5ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kPNPG7ABSxeK0NszPA0J/I9gsf/s5VY8PAp3YInBSEfhTp7Xn1f5tMtKySWD?=
 =?us-ascii?Q?yPRsoReF1ZJTUzQNqxd9enqpZOrigoUsg2mlLW07wsncIiDJA7i7kUIWQWze?=
 =?us-ascii?Q?BoJW/UmXwifzhx8GikU0BLCR9l7LFCupdZk5mh59X6yYFqp+nT4X3jWXTa/R?=
 =?us-ascii?Q?x/v2toXqmOol1nCCEk77IduoDgGGwPRGR6NZf+D9pDuyBMucQgdthV7KgeGo?=
 =?us-ascii?Q?BszijW5qRRX8+HwhACN0zSc2JSejxXyKCiVHCKm56fcUciBynIKsrd1yETR9?=
 =?us-ascii?Q?0Snv9d5wCbIkWl4jDBgnnY8Lm1FERiJIj7TdM8dnZ/XZWE8ir0MR/uBMczIm?=
 =?us-ascii?Q?g4N6orjFIuMVFROrUFnJlzUBe3plyTSaK/WNfn9MFAHsI+JwWhGlATXNF4zs?=
 =?us-ascii?Q?bEdCIb+oHb6pAwvqnjEaqn+fCIe0XqFGkyc2+J2hdcZqhNrmOEgzQuObNMWi?=
 =?us-ascii?Q?tY+D0faFtn1T9VIeO/91G/BwCi5Sg7jmQIxBGVxPwS7ksigf/+J+6HLk4S/O?=
 =?us-ascii?Q?8lGNirPQpNV+WPQ4GT3W5yt3JR1Ub2djhq/yr/ofSx4AUT9RQtBIfseWHTW1?=
 =?us-ascii?Q?odQPktAEq6w576z8t4SoWeWcKfzmZH5GqpIx+kraNmzeUYwQj1E4uTML++7Q?=
 =?us-ascii?Q?Vh4rC9z6RKWmpwQIx8L/MQ69PO32H9Lm/lHyPQfFeJPAyTMPRvXnmMBmPTkn?=
 =?us-ascii?Q?qxDgZHkKJ/2y7FBK2S6ub78TIKdJokQA2/p5y1dPBGZHe+epFUqcO5u0sRQ1?=
 =?us-ascii?Q?roVF7ltRr+8ydELwhhMAVhxyOiuNz37pLQMTKTbXk99/DyCQAG1noa68HbL4?=
 =?us-ascii?Q?9zCUhhHun9SOJGLY6CRgDCIMCur6sgYTCi3+wpy7DdiOOmQmFfbM7rbx8JzN?=
 =?us-ascii?Q?M/DS1HZ63VQ7RCnLJi9dB24YsBHzrngPVYPNjl285AyrcEUNAO7Nj7DBkqHw?=
 =?us-ascii?Q?zxT0dG8lCDLGZTgv8fge1OoF5R51UbBzuYR5Ipw9j2+teduGRuB+0PiPXT4o?=
 =?us-ascii?Q?EeP21lzbgAeNU7WZJoaPsQcZieN4IH9cTqn2rhwz8z/BpuBGtdH76zSaz7Qk?=
 =?us-ascii?Q?bvo8Gw+AjOWdxEVzxLB4PQyt8d3tY3+odkyWJTXPXhc5vC1V6sOXhSyZKLRp?=
 =?us-ascii?Q?wuV8Wqy6GqDfzgyIOsQpxBeV8hNqoswqAFCjtGjwehYTVHnIJJXC8iroNyD5?=
 =?us-ascii?Q?nsqaaVgXJblBpsJ0QGhlwo0GtaqAS4oWzksTOuaYTMdIVUoeGVhDCbCdRZX7?=
 =?us-ascii?Q?+3+7sD8RcaOSx5vkhHw7Hj9/XvG3+UixcuVbfdNiTtSo3POru9Rc1Aoggi0X?=
 =?us-ascii?Q?ZJKEA0PUprTOnvEtwEp8Z44mIEigmVfQQbs0uwootBc8ued4HwEUoMv5AyDh?=
 =?us-ascii?Q?P0OVC9w9HS3uqO8x/A5IcJsK81rh7swx13aoN52NHgukyMf/BE0zJKwnYX0k?=
 =?us-ascii?Q?UArhusgJfIuWVKR7AJQhHehEknMjnG/lBWWxBvZxv2rF1OwqKLJafsrVkZa5?=
 =?us-ascii?Q?NzF/1f5Zco0X5D8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QiV/P2xbYQhcv16oafn7kbXyhTOFMrZJW9YIDv8LmfaQ7jXrcoZbFlxC2Ixe?=
 =?us-ascii?Q?F1hqs9pQE+V0rqTQ8Sb7AWQIFa2hJ5No6XQ0lTmlNLXI+cHbQgLXztK0iSQv?=
 =?us-ascii?Q?gnzXNGgbdj87QvHK0JzNx/1xJg4R6tcT29lSSz673Do7fG6Q3wWnKu87ZzoQ?=
 =?us-ascii?Q?jg0yOaQrfj9RRg5kREO9MCpp/3mfG9lAJoC2X0ITi6UtiigcXzifK4zs2WSW?=
 =?us-ascii?Q?RFxdny+VwhHghB9KePnnP2pg02b4hUYTRDkigzO/VLx2jSdq9nvx0LsSVRLW?=
 =?us-ascii?Q?PwLTXg9OKxooOg7r0JZUMwSdwzIoiKemRTPi8QV6pQL0ZrhlAkxWrQfoeyIG?=
 =?us-ascii?Q?TbVSeRPfajYCMIrGW3XRk4l7bOaKvt0rjMiqJgsHC9fzcPeNwUlAyt8Z3adP?=
 =?us-ascii?Q?1/+Ers/1RbwPvD1PBTUPzXuLVGj9rtFzpMA7n0fUFt7eTXymiJpKwdKK8CUa?=
 =?us-ascii?Q?e9OGJ1gXZo81gnrInsoqRmy2rATXbZznLGKkFxOw+jKwl97XycHkF7MOO9M5?=
 =?us-ascii?Q?QdmQRh5iLAbo2kbYtEV8buZG/OeM5GoPXDsOc9yDiD913RI3d+sOiTjdIWVf?=
 =?us-ascii?Q?eoNWYtH8EDyJEEwqbVH5EFsGm+YeV3NcqsTwmbuvBcU3miIOT6W4u7GoUbhD?=
 =?us-ascii?Q?4KkKs0d3nxTx7hPCED+mMbz6T+np6mi0jd42Pes/pahtgcBA+kgu1LCDbvXk?=
 =?us-ascii?Q?cCs/sDqQ2SHQzjVxmBRAqgO7p6ZLC2VWw2IysgdfBB9S53Mzk7f+3s3bgJAA?=
 =?us-ascii?Q?0VfSxBd+LTF/21+SR7nfSZ20IY1xkD4n0r7dKLzrzGJPC9TvmBPbToboSSW6?=
 =?us-ascii?Q?tmqUWAjAbjLlu4t4gKGJVI8eqW6bq3Kqm9+Q4kfAE6IpiLcUShU8xYZUA5BW?=
 =?us-ascii?Q?4hEaSe3P2qTO2HS9u/2echEecjxSJul0M37LeeidMa+bduNRI2ORF+FfRSG/?=
 =?us-ascii?Q?RIYL0qfM/shxVhW+/bOXwpi6Hq54yZjtzMvUsZzRMg27nQF5T8HFNvAMoCwI?=
 =?us-ascii?Q?uw4BIobl/ZPgTkBIJfvOm0e1LzsV+diYCfh8PlhKc0V4921a7bIwuPZI2NFu?=
 =?us-ascii?Q?kxoJGqUSOTeqnTrf+5O7xxrtAKCjVMaLUEr6vxpukaCPQzYZUjRYSNAsY1gR?=
 =?us-ascii?Q?9ZIBnMnHW8QW/snKP0JCEygL2jv6uSvF/6q4tjBtDzJ4bfAXkHMEi6Jda9jo?=
 =?us-ascii?Q?9GZDODYEOF80ghwbCR+JmR//99KJbHX92enytIYwApM1S7wRGmolopKzJjuE?=
 =?us-ascii?Q?YBZrTc6+LQeG2MP5RAKYqaMqpA4P5SWUf/zcvWCUFAFvBi+FJLOX/1IMEHSJ?=
 =?us-ascii?Q?D3CHzCFEyCGGeF6rV+5TnKvTmxYs5/4cDuiotBjtduCXgntTBKcuityUKuGQ?=
 =?us-ascii?Q?BacvuAZ+ALjPNQSGK3irvUPiYEfPuS4lIijiXUtzdrRtO6vvefn/L0eJcuXC?=
 =?us-ascii?Q?++pH1/7WgtKf7u+w0pDCJgtbRdGYWduft2u68lQZzexS6RgQ2FJYe9BrIvC/?=
 =?us-ascii?Q?ZPK71HfUyJ/58k0dQ+4M+rWXDvXzoHsfxgSuNF+sjoWzJcVwyjs0/XobFt5U?=
 =?us-ascii?Q?NC6rnl+0VBJuM6ziY+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198311c0-d13c-42c1-4eb9-08ddf00bb5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 01:45:24.3746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4aZWg3jNKuaTSgjZo94WBFCEQzXshsepYeIyfpeDKKxIduq4HybnTdR382s3BGZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
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

[Public]

Ping..

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, September 8, 2025 10:40 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
>
> Since the PD BOs are assigned at initialization, the placement stage can =
obtain the
> PD physical address
> (PA) directly from the PD BOs without additional lookups.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 260165bbe373..fd9cbbebbdf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -476,7 +476,7 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm=
,
>               return ret;
>       }
>
> -     vm->pd_phys_addr =3D amdgpu_gmc_pd_addr(vm->root.bo);
> +     vm->pd_phys_addr =3D amdgpu_gmc_pd_addr(pd);
>
>       return 0;
>  }
> --
> 2.34.1

