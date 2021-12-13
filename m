Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F406C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 20:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD6E10E6E8;
	Mon, 13 Dec 2021 20:07:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E427D10E6E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 20:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7EY5k1NAxSTbSXRuGofIdDPp55/OgeeuCo7XZpJJcTGwSPsAgzkkGfMa5l1l5Q0jPshQDZ3vG7/iz7fHEbe41YyOq2rP4qRLjq+w2dHAGNvL6DU4JtqrG8jNXZVVTi0fvEby3L/Jdk/ruckjSZfaAp1m0tZ8ECw/6RmDs2h3OQx2rxsKKRijfVCEqcP8p3j/PvAENgxpsNkpPM2WYMGyYAqkgZrHyRP4V9Sg5NHY190dOeY5YB9u4FSTAhDGw1IciFWXSIuplnPlAmArf55nBCM8gfxzWsAvnx9pAp+nq7/Sop1/+Lg5U18bx14dzwmEIf2KIZnWCZV9EWldu+qGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp3Snb1eFL0Uuf9mqkqEBPQ9XXub4UpVYqaqhsHKJgY=;
 b=EaZVVopl3O80EMYOeVt45VpC1TT6S/Zg8UyKzZS+MEaIjxqbEhoJb4g6yU/yIOwJDV0CJFG+6IzMIiYjgAwAO72FWWLPPVHYMWcV5Rnbn2awPaoVkccfUzuhFv9CnSy7yOKkwoVVs0IwFs5TO+YDfbO+esq5zNHAnXJiJBqS80o/I7pzZJa5TzO5NrBdYSwAI6j1VgUVvO45C9ytrGuId+3QvfXaQoBRy4bNBktW+ekkLVlvZEFOwWGOvJ2ADSk5cUo9NinCffjhZmjo0HpIJgjnfauZbZEk7s1pjef6xgUkdoF7459+xBX3t2lI/RLXG14nQCb2H5D20CO9ne5IhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp3Snb1eFL0Uuf9mqkqEBPQ9XXub4UpVYqaqhsHKJgY=;
 b=eGDRSzlveIklTF2N/VNJNGvL9VRuQmcIi+sXTsBWHw2U8vJioncacnfp1mkPr/aY68empWaCik1NTSIJxgww1hZtz9Dn7ZVVduFgLk4mAai8KC5vNKH+PI9LdEQs0iNVp5v/1wN+m7mag0/8dkiKNlXCC/8zaGRduiqkJfLFusM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3646.namprd12.prod.outlook.com (2603:10b6:208:c5::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Mon, 13 Dec
 2021 20:07:07 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 20:07:07 +0000
Subject: Re: [PATCH v2 1/3] Documentation/gpu: split amdgpu/index for
 readability
To: Yann Dirson <ydirson@free.fr>, amd-gfx@lists.freedesktop.org
References: <20211210182030.3834-1-ydirson@free.fr>
 <20211210182030.3834-2-ydirson@free.fr>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <c47a7b5b-a77c-6538-97e9-cb665f6e4dae@amd.com>
Date: Mon, 13 Dec 2021 15:07:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211210182030.3834-2-ydirson@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:610:60::38) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 310621c5-3c1c-4612-f1f6-08d9be742357
X-MS-TrafficTypeDiagnostic: MN2PR12MB3646:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3646432C747583F37C14C1F598749@MN2PR12MB3646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7uJqfW7/JKEwlvNevIeFJ5ujVGZG87YqME90hIpx4vLaXdJKhhlycIJ89s0UNQkHGsjfC0eton3wBrj5cEx4P5hfhmlWS0HjLjklwZF0zoNZKV8RUtSG3D+I/AGFSrZGICFce87B7LmaC+/qLRNzQdiwOw/y8XzpYYex9dlr8p1Oq9oNJWnRMPDtvzJUApDPccS/uJ22VvWSPc/V8KYEJSpeWjqkwC0WiPeZ5z9xiXv3Oz7HLeaWQ7ExMD3DRU7oDtePsplV0dTMQYGuQIjPi8Ymyta4FzHEwZEgWNjG+Cj103EjNv+Vt4taiiUhmNzIWtfeI35kQuK05Na9utasr+cYF2niQmP+hjniCvN5iNy9cGMnVGlxJTL4ACbc2lCkpuGih7xWKCLz8LmXPD5lB02qnlhupLNZjQWvVcFdxdZSdg3b9Oy+I8S/ih3Zhat1v7TNCYkGwGDxOL7qENiTCc+VFGnkRT5u50CH29bzS9H7S3GhDMJHWm3I/6o7OjB2AI9fmmGglfgSTIQIcnXxyRsqF8h3JR615OWDAoUf+98Se3Jh58GPDLtyO76FSkyXuVzi8mnjP930e+TWZRX2LFizaqnZacyn7DOiedXpKpbVyE+6xfow6gkYUMgY/3KC9g4KP/3MxzBi6h5j5wY0MgTC/EjeBZK08O9v+RBWgdT+DEqzdG1xjcAjwMAnpJrRgrPQk3HX6ivtPYUIqVtpOVBsIW5AC/5UOwh9a2Efk2PcmRYWEYASNV+gdzBvO09za/Ed3X3tbgLjvkx10XOQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(508600001)(31696002)(4326008)(54906003)(8676002)(36756003)(6486002)(186003)(6506007)(31686004)(2906002)(53546011)(30864003)(66556008)(316002)(38100700002)(2616005)(4001150100001)(8936002)(83380400001)(5660300002)(6666004)(66946007)(66476007)(45980500001)(43740500002)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTYzQ1VGSkJuT3pzdGJYLzU5eU9sZmJGUEExaGVDRUVSeWJiWEViOFBZNDFQ?=
 =?utf-8?B?dW5ESEx1UzdaVUJ2bEE4RFNMT0FiOFZCbFFPaXRzbitaVVBHaytKa1RxRm1t?=
 =?utf-8?B?Y3laZXV4dncxbnN3UktGcTcyM2F4NWF5SGlPZ09UWHc5QXlGdTRUVWZ3V0Vt?=
 =?utf-8?B?TnBoRDZMM0hQSHNiVjZ2TkRCd0hxRmJOMm5CMlhZTWpXYUhrL3MzdVBxeWtv?=
 =?utf-8?B?VFV0SkprZnNZMDhRMkE3VmVnUkIyZ2Q5ZU1sMU5NejA2TEIwUGVCSmErZ2Ru?=
 =?utf-8?B?b2hyTzJTZlVramYvODZuazFDN3VVbmNpU1plRC8wSUpmSHFjV0NUcXExYk5x?=
 =?utf-8?B?SXBWYVBNRGdiRW0rUXcwbU15SjBVTko2ZVdFVTJxSTBmS21YWXNqYXNJTC9w?=
 =?utf-8?B?ZlkyNmFuS2pTdHdpdHExdlVQa3Q4S0NGNnJZbVpUOU16cmZXYnN1NkdFUDlW?=
 =?utf-8?B?VWd1dzM2SGsxY1NtYm4yMk45Y01uV0RFaXRBNURvZi9Mek8zUzJJN3RwMGEz?=
 =?utf-8?B?eDVBOHF0dW9vZHBFMUVQY1FNbmVyRjJ5ZnRqL0dlTHhDT2p6QmhIR042RC8z?=
 =?utf-8?B?Z0lnck5DRVFYdi9TdGxScnJ5Y0U3UW01QnU1VHRjRkdvOHVKYjVBTTdBYUc0?=
 =?utf-8?B?MUYzcTBkREpJNWViS0hMN0lWSDJvMzZQaXlvV3NaTnNRaWdTMlZFdFZ2MGJx?=
 =?utf-8?B?WVFXYitNT1JqSXdQenpKZzBJTkljckxUL0NaOXVaZzNEYWlkWnNYd2ZIUFJn?=
 =?utf-8?B?QlpZSklTalFMOGF1KzZkQ05RZ0RnaFdHdTIzbjhmVXVFb09MYmh3aWluS1lw?=
 =?utf-8?B?aFJaaXRVVDVla3RMVUZzTWcveGc5TEU5UFNZL2dCaThvU29lZlJrM3BHYWxn?=
 =?utf-8?B?cWZHbzRrZWh3TVJZOHFDc3dDbXRFcTRuNzRzQURPNXozb3djNUFzc1prcFY0?=
 =?utf-8?B?VGx5WktGS014M2U4UFk1bnFjKzhiZUN5bW1Bd05Xa0ErVnFzMW5yRUp5WWMw?=
 =?utf-8?B?dzdDejdmbWlyb0tVaVlmc1ZsQUNSWWpCVktDVFJENGo0VGM1aGNYbVB3Nk5Y?=
 =?utf-8?B?b2cybXJVNVVRdnJDeTZTbzhmQW5hOGJuNVBHVEx4eDJNSWREdFRDcjYrdkg2?=
 =?utf-8?B?N2lWSTVGZWUwVkZDbVQ3ZUlxVk1yckQ5dTgzMmtTZ2VVUnVUOURTY3o5TlRi?=
 =?utf-8?B?bXd4UDJWNjFtTU9qV2x4WHZXdzRWQ29zcFBSUnd0R01SV1NDdzgrWUh5SXhl?=
 =?utf-8?B?QTNUM2ZWU3piYmpXRE4zdnMzZ0tVK1NqV1p0VVZiT2N1NFBUQytXWmpFNmND?=
 =?utf-8?B?cTU0UllKaTdjRTd5V2E4TlQ0djYzNlMvclA5NjJZLzRaMlBpejdVR25aOEFh?=
 =?utf-8?B?U2QxdXphMHBUUXhEM3hUZjNHVXpzMENHeEpxRk05R1JmM2N5dUdabmVndzJK?=
 =?utf-8?B?bmZmckdxRjhNUjUyUGhrcWpDM3lvUUJ4Z1VuTXFzR3RnMVBCUks3dTJIenlU?=
 =?utf-8?B?RldNOXIzNHlJMHc3dGo5QmFMd0t4NUhTaEZTNnp4MXpzQytpTGFUMFpjVmZt?=
 =?utf-8?B?M051WEExTTMxcWQySnhwMDV1anN5d2I0d1RZRlpxRi93elNJeG1GODlpWkEv?=
 =?utf-8?B?NmpraFV5alNTam5jMk52U0pBdGo3RFdFLzNPRURsbHpwTUIrMUdqcTFmRXd5?=
 =?utf-8?B?QkMzKzlNdEE1Q2VpdjVjcDNGMFRWMWlCSTd2YmVPQ2F6TlRncUxmbmp0dVNv?=
 =?utf-8?B?T3JWU1VSSUhZL0ZDYzhmdE01dHZFb3VCOGNPTjZkN2lJbXM2N2FHbU0rSW1N?=
 =?utf-8?B?RzUreVNTSFNPOC9jR2F1ZFR3MzNrNTdvcVRjVGNzNVhUL1dyUzU2K2ZhMVNr?=
 =?utf-8?B?YU14N0tieXFHRU1saXIvZkJaYzRRckdiRHYyVUFBT2VpS25waGtxcVNOWG80?=
 =?utf-8?B?TGVNU2xhQjZQWmJLa2x6NXR4V2liRGIzbnZQUnJpR3UvZnZ3dmN4VEx5MGhs?=
 =?utf-8?B?YTN3QmFUS0pCL1k0TFJNWEExSjZ5L1NlNU1URXVMK29HenZXNzgvbmZSblZw?=
 =?utf-8?B?dHRTQ0pGWElCMFNjUGZ6bEdQUnArSk1PK2UyWm5hY2pWQm40NUU0dDkvQ0Qz?=
 =?utf-8?B?RmdQRHNyMXpScVlIZzFHTEsrdzdnaWR2VE5RWERFU1UrZkVrS3hFN0lSUzJT?=
 =?utf-8?B?dy9BVmFNdEdVZXM4L2VGVXZPdEc1bzkxVFRiK0NTSXdVSXRXR0I1aE5RUjla?=
 =?utf-8?Q?8pZ22KTLJp8J502qH3ZyrVU15nODxu97auDV48eJVM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310621c5-3c1c-4612-f1f6-08d9be742357
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 20:07:07.0074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTBasqdXa+Yl0U1tiGPdRzGOGRD/5onzZtjnJeyjJC0pcfr/GR4Tn2r7+qbN0UxnCokMDRkzs9ThzT8E3eJ9ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3646
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-10 1:20 p.m., Yann Dirson wrote:
> This starts to make the formated index much more manageable to the reader.
> 
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>   Documentation/gpu/amdgpu/driver-core.rst      |  65 ++++
>   Documentation/gpu/amdgpu/driver-misc.rst      | 112 ++++++
>   Documentation/gpu/amdgpu/index.rst            | 342 +-----------------
>   .../gpu/amdgpu/module-parameters.rst          |   7 +
>   Documentation/gpu/amdgpu/ras.rst              |  62 ++++
>   Documentation/gpu/amdgpu/thermal.rst          |  65 ++++
>   Documentation/gpu/amdgpu/xgmi.rst             |   5 +
>   7 files changed, 324 insertions(+), 334 deletions(-)
>   create mode 100644 Documentation/gpu/amdgpu/driver-core.rst
>   create mode 100644 Documentation/gpu/amdgpu/driver-misc.rst
>   create mode 100644 Documentation/gpu/amdgpu/module-parameters.rst
>   create mode 100644 Documentation/gpu/amdgpu/ras.rst
>   create mode 100644 Documentation/gpu/amdgpu/thermal.rst
>   create mode 100644 Documentation/gpu/amdgpu/xgmi.rst
> 
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> new file mode 100644
> index 000000000000..97f9a9b68924
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -0,0 +1,65 @@
> +============================
> + Core Driver Infrastructure
> +============================
> +
> +.. _amdgpu_memory_domains:
> +
> +Memory Domains
> +==============
> +
> +.. kernel-doc:: include/uapi/drm/amdgpu_drm.h
> +   :doc: memory domains
> +
> +Buffer Objects
> +==============
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +   :doc: amdgpu_object
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +   :internal:
> +
> +PRIME Buffer Sharing
> +====================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +   :doc: PRIME Buffer Sharing
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +   :internal:
> +
> +MMU Notifier
> +============
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +   :doc: MMU Notifier
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +   :internal:
> +
> +AMDGPU Virtual Memory
> +=====================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +   :doc: GPUVM
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +   :internal:
> +
> +Interrupt Handling
> +==================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +   :doc: Interrupt Handling
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +   :internal:
> +
> +IP Blocks
> +=========
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> +   :doc: IP Blocks
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> +   :identifiers: amd_ip_block_type amd_ip_funcs
> diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
> new file mode 100644
> index 000000000000..e3d6b2fa2493
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/driver-misc.rst
> @@ -0,0 +1,112 @@
> +================================
> + Misc AMDGPU driver information
> +================================
> +
> +GPU Product Information
> +=======================
> +
> +Information about the GPU can be obtained on certain cards
> +via sysfs
> +
> +product_name
> +------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +   :doc: product_name
> +
> +product_number
> +--------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +   :doc: product_name
> +
> +serial_number
> +-------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +   :doc: serial_number
> +
> +unique_id
> +---------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: unique_id
> +
> +GPU Memory Usage Information
> +============================
> +
> +Various memory accounting can be accessed via sysfs
> +
> +mem_info_vram_total
> +-------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +   :doc: mem_info_vram_total
> +
> +mem_info_vram_used
> +------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +   :doc: mem_info_vram_used
> +
> +mem_info_vis_vram_total
> +-----------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +   :doc: mem_info_vis_vram_total
> +
> +mem_info_vis_vram_used
> +----------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +   :doc: mem_info_vis_vram_used
> +
> +mem_info_gtt_total
> +------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +   :doc: mem_info_gtt_total
> +
> +mem_info_gtt_used
> +-----------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +   :doc: mem_info_gtt_used
> +
> +PCIe Accounting Information
> +===========================
> +
> +pcie_bw
> +-------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: pcie_bw
> +
> +pcie_replay_count
> +-----------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +   :doc: pcie_replay_count
> +
> +GPU SmartShift Information
> +==========================
> +
> +GPU SmartShift information via sysfs
> +
> +smartshift_apu_power
> +--------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: smartshift_apu_power
> +
> +smartshift_dgpu_power
> +---------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: smartshift_dgpu_power
> +
> +smartshift_bias
> +---------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: smartshift_bias
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
> index ff38c360b04e..a24e1cfa7407 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -5,339 +5,13 @@
>   The drm/amdgpu driver supports all AMD Radeon GPUs based on the Graphics Core
>   Next (GCN) architecture.
>   
> -Module Parameters
> -=================
> -
> -The amdgpu driver supports the following module parameters:
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> -
> -Core Driver Infrastructure
> -==========================
> -
> -This section covers core driver infrastructure.
> -
> -.. _amdgpu_memory_domains:
> -
> -Memory Domains
> ---------------
> -
> -.. kernel-doc:: include/uapi/drm/amdgpu_drm.h
> -   :doc: memory domains
> -
> -Buffer Objects
> ---------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> -   :doc: amdgpu_object
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> -   :internal:
> -
> -PRIME Buffer Sharing
> ---------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> -   :doc: PRIME Buffer Sharing
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> -   :internal:
> -
> -MMU Notifier
> -------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> -   :doc: MMU Notifier
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> -   :internal:
> -
> -AMDGPU Virtual Memory
> ----------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> -   :doc: GPUVM
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> -   :internal:
> -
> -Interrupt Handling
> -------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> -   :doc: Interrupt Handling
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> -   :internal:
> -
> -IP Blocks
> ----------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> -   :doc: IP Blocks
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> -   :identifiers: amd_ip_block_type amd_ip_funcs
> -
> -Display Core
> -============
> -
> -This section covers Display core.
> -
> -.. toctree::
> -
> -  display/index
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> -   :doc: overview
> -
> -AMDGPU XGMI Support
> -===================
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> -
> -AMDGPU RAS Support
> -==================
> -
> -The AMDGPU RAS interfaces are exposed via sysfs (for informational queries) and
> -debugfs (for error injection).
> -
> -RAS debugfs/sysfs Control and Error Injection Interfaces
> ---------------------------------------------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> -   :doc: AMDGPU RAS debugfs control interface
> -
> -RAS Reboot Behavior for Unrecoverable Errors
> ---------------------------------------------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> -   :doc: AMDGPU RAS Reboot Behavior for Unrecoverable Errors
> -
> -RAS Error Count sysfs Interface
> --------------------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> -   :doc: AMDGPU RAS sysfs Error Count Interface
> -
> -RAS EEPROM debugfs Interface
> -----------------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> -   :doc: AMDGPU RAS debugfs EEPROM table reset interface
> -
> -RAS VRAM Bad Pages sysfs Interface
> -----------------------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> -   :doc: AMDGPU RAS sysfs gpu_vram_bad_pages Interface
> -
> -Sample Code
> ------------
> -Sample code for testing error injection can be found here:
> -https://cgit.freedesktop.org/mesa/drm/tree/tests/amdgpu/ras_tests.c
> -
> -This is part of the libdrm amdgpu unit tests which cover several areas of the GPU.
> -There are four sets of tests:
> -
> -RAS Basic Test
> -
> -The test verifies the RAS feature enabled status and makes sure the necessary sysfs and debugfs files
> -are present.
> -
> -RAS Query Test
> -
> -This test checks the RAS availability and enablement status for each supported IP block as well as
> -the error counts.
> -
> -RAS Inject Test
> -
> -This test injects errors for each IP.
> -
> -RAS Disable Test
> -
> -This test tests disabling of RAS features for each IP block.
> -
> -
> -GPU Power/Thermal Controls and Monitoring
> -=========================================
> -
> -This section covers hwmon and power/thermal controls.
> -
> -HWMON Interfaces
> -----------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: hwmon
> -
> -GPU sysfs Power State Interfaces
> ---------------------------------
> -
> -GPU power controls are exposed via sysfs files.
> -
> -power_dpm_state
> -~~~~~~~~~~~~~~~
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: power_dpm_state
> -
> -power_dpm_force_performance_level
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: power_dpm_force_performance_level
> -
> -pp_table
> -~~~~~~~~
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: pp_table
> -
> -pp_od_clk_voltage
> -~~~~~~~~~~~~~~~~~
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: pp_od_clk_voltage
> -
> -pp_dpm_*
> -~~~~~~~~
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
> -
> -pp_power_profile_mode
> -~~~~~~~~~~~~~~~~~~~~~
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: pp_power_profile_mode
> -
> -\*_busy_percent
> -~~~~~~~~~~~~~~~
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: gpu_busy_percent
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: mem_busy_percent
> -
> -gpu_metrics
> -~~~~~~~~~~~~~~~~~~~~~
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: gpu_metrics
> -
> -GPU Product Information
> -=======================
> -
> -Information about the GPU can be obtained on certain cards
> -via sysfs
> -
> -product_name
> -------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> -   :doc: product_name
> -
> -product_number
> ---------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> -   :doc: product_name
> -
> -serial_number
> --------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> -   :doc: serial_number
> -
> -unique_id
> ----------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: unique_id
> -
> -GPU Memory Usage Information
> -============================
> -
> -Various memory accounting can be accessed via sysfs
> -
> -mem_info_vram_total
> --------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> -   :doc: mem_info_vram_total
> -
> -mem_info_vram_used
> -------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> -   :doc: mem_info_vram_used
> -
> -mem_info_vis_vram_total
> ------------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> -   :doc: mem_info_vis_vram_total
> -
> -mem_info_vis_vram_used
> -----------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> -   :doc: mem_info_vis_vram_used
> -
> -mem_info_gtt_total
> -------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> -   :doc: mem_info_gtt_total
> -
> -mem_info_gtt_used
> ------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> -   :doc: mem_info_gtt_used
> -
> -PCIe Accounting Information
> -===========================
> -
> -pcie_bw
> --------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: pcie_bw
> -
> -pcie_replay_count
> ------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> -   :doc: pcie_replay_count
> -
> -GPU SmartShift Information
> -==========================
> -
> -GPU SmartShift information via sysfs
> -
> -smartshift_apu_power
> ---------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: smartshift_apu_power
> -
> -smartshift_dgpu_power
> ----------------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: smartshift_dgpu_power
> -
> -smartshift_bias
> ----------------
> -
> -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> -   :doc: smartshift_bias
> -
> -AMDGPU Glossary
> -===============
> -
>   .. toctree::
>   
> -   amdgpu-glossary.rst
> +   module-parameters
> +   driver-core
> +   display/index
> +   xgmi
> +   ras
> +   thermal
> +   driver-misc
> +   amdgpu-glossary
> diff --git a/Documentation/gpu/amdgpu/module-parameters.rst b/Documentation/gpu/amdgpu/module-parameters.rst
> new file mode 100644
> index 000000000000..ea538c8dda35
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/module-parameters.rst
> @@ -0,0 +1,7 @@
> +===================
> + Module Parameters
> +===================
> +
> +The amdgpu driver supports the following module parameters:
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> diff --git a/Documentation/gpu/amdgpu/ras.rst b/Documentation/gpu/amdgpu/ras.rst
> new file mode 100644
> index 000000000000..047f76e395cf
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/ras.rst
> @@ -0,0 +1,62 @@
> +====================
> + AMDGPU RAS Support
> +====================
> +
> +The AMDGPU RAS interfaces are exposed via sysfs (for informational queries) and
> +debugfs (for error injection).
> +
> +RAS debugfs/sysfs Control and Error Injection Interfaces
> +========================================================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +   :doc: AMDGPU RAS debugfs control interface
> +
> +RAS Reboot Behavior for Unrecoverable Errors
> +============================================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +   :doc: AMDGPU RAS Reboot Behavior for Unrecoverable Errors
> +
> +RAS Error Count sysfs Interface
> +===============================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +   :doc: AMDGPU RAS sysfs Error Count Interface
> +
> +RAS EEPROM debugfs Interface
> +============================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +   :doc: AMDGPU RAS debugfs EEPROM table reset interface
> +
> +RAS VRAM Bad Pages sysfs Interface
> +==================================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +   :doc: AMDGPU RAS sysfs gpu_vram_bad_pages Interface
> +
> +Sample Code
> +===========
> +Sample code for testing error injection can be found here:
> +https://cgit.freedesktop.org/mesa/drm/tree/tests/amdgpu/ras_tests.c
> +
> +This is part of the libdrm amdgpu unit tests which cover several areas of the GPU.
> +There are four sets of tests:
> +
> +RAS Basic Test
> +
> +The test verifies the RAS feature enabled status and makes sure the necessary sysfs and debugfs files
> +are present.
> +
> +RAS Query Test
> +
> +This test checks the RAS availability and enablement status for each supported IP block as well as
> +the error counts.
> +
> +RAS Inject Test
> +
> +This test injects errors for each IP.
> +
> +RAS Disable Test
> +
> +This test tests disabling of RAS features for each IP block.
> diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
> new file mode 100644
> index 000000000000..8aeb0186c9ef
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/thermal.rst
> @@ -0,0 +1,65 @@
> +===========================================
> + GPU Power/Thermal Controls and Monitoring
> +===========================================
> +
> +HWMON Interfaces
> +================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: hwmon
> +
> +GPU sysfs Power State Interfaces
> +================================
> +
> +GPU power controls are exposed via sysfs files.
> +
> +power_dpm_state
> +---------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: power_dpm_state
> +
> +power_dpm_force_performance_level
> +---------------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: power_dpm_force_performance_level
> +
> +pp_table
> +--------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: pp_table
> +
> +pp_od_clk_voltage
> +-----------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: pp_od_clk_voltage
> +
> +pp_dpm_*
> +--------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
> +
> +pp_power_profile_mode
> +---------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: pp_power_profile_mode
> +
> +\*_busy_percent
> +---------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: gpu_busy_percent
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: mem_busy_percent
> +
> +gpu_metrics
> +-----------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: gpu_metrics
> diff --git a/Documentation/gpu/amdgpu/xgmi.rst b/Documentation/gpu/amdgpu/xgmi.rst
> new file mode 100644
> index 000000000000..23f2856f4524
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/xgmi.rst
> @@ -0,0 +1,5 @@
> +=====================
> + AMDGPU XGMI Support
> +=====================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> 

lgtm

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks.
