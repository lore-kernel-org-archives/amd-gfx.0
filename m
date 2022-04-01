Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF9FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 08:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAB0112257;
	Fri,  1 Apr 2022 08:56:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101FF112257
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 08:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be4lAFD2omVpfh6eVe+F9F/Wxs4J+nw+M2TPg2yY/JpIHoODhdh66JYa6mR8NSfOaXrIgK8Z9oXAjf4ZChXAEkcJsbYwd1MCD5bQ07iYgP9oAeaLaaXzuJ9mKLZgjoFHN4Uy5mBGP+wWl9QKwfTcRI5kCgWvpI8QjL2VgKB1zYutougmUxKxLc4dzK2t2vf5zahdrBNpfFPHKCcXfwbHnGrhQQf67bEd59ceT4SEnYOAFOFKynpe8dyDYuYGTywDyn80UQrZSpYU5vi3ABXUboO9wyQ6aK+B7KVwBKZ4xE8J6KlCm4d49TYV0jE/tkqbt6X/buEJPtmzT81IL4qTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/iuRrJF7CYBvnklNr7EzVNMFktg0lw2R03B3ReMAWs=;
 b=d76n7EI2xdLwzLQJG2iHd792p9Sq+hSsGjzCyUAH4DC1zJg+8EFvouAsLZg7kfR6Ya9KEEDqzybn16n1vnA5RQ2Xnuf3pbgTpAVa3B3qurZKrf9ZgiPCxxxFCuWeyuqljHUD8E2FPqcxRPrSn6Z4kRgkMimA/Xs9gFBkxG8dsFTv/DulruHAeNtD2WVdoICPTntSEkvzp1ohvBMecoYyiY0Zk3JYjkIFxbD+wZpH6wXuKZpf0FZpvZw5+cyTqOQ48K1xz1IZSUHWdfg2PPo/8tkjkp4omBONHUqAgZDwyM27P3IJD2ZjQqrjXWAKIPQQxyEqy55dHvQog6/dp08Ifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/iuRrJF7CYBvnklNr7EzVNMFktg0lw2R03B3ReMAWs=;
 b=Fz6DU4ZYLJYNkgv4u0tfSstKEFJoJLZIjfZqNo7Yf5bVwl8sizFx2iTGxj+cYifRXrhQ7D9QxCZllAix9v0McFcBAhcN6TjVPIV1EL3wjjj6aFykgEScVAFDrXrmwj6tD1hXg/AM3rF217azBU0arI1hy7UgeC/8TylWDLNE6Uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR12MB1229.namprd12.prod.outlook.com (2603:10b6:300:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 08:56:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Fri, 1 Apr 2022
 08:56:29 +0000
Message-ID: <5961c4ac-f342-6ca3-ffd3-a41a4345445f@amd.com>
Date: Fri, 1 Apr 2022 10:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Content-Language: en-US
To: Arthur Marsh <arthur.marsh@internode.on.net>, evan.quan@amd.com
References: <BYAPR12MB2615DA93084138A62E593442E4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
 <20220401084952.4536-1-amarsh04@internode.on.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220401084952.4536-1-amarsh04@internode.on.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0044.eurprd06.prod.outlook.com
 (2603:10a6:203:68::30) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aaa022a-b558-4e73-c4ce-08da13bd8269
X-MS-TrafficTypeDiagnostic: MWHPR12MB1229:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB12294222FC858BB4D5EF8BB983E09@MWHPR12MB1229.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR9Rm3Y2vG8gCFBw/6Q4V85gDLbOH99Wau0ilbTcn4Aq6qitd1z2n0jhP7H9rKlYF3DpTaZEbk3jbZZeuRZngZD/pU59YCekSUS5NG+ny45fazFyIm8uU75P5mteJ5fqsyEa5PLRYAd5cd9+R+SIQ5EDU+VUBchedlhqzTUkyeoPf15E+RPA6xNCZENLMa0grbmXdqbK5uaV19T8gzkhQToOGGQV8JeECOpHz0YuMIzjIa6cj06YsXkiS41caRqrJ+cADchfFow57FkdqMKTeiGJAzK2FK9Ao1Q0gWfJhrOojBzYu2OWbctfEi31BH10Jg4/7rX/u+lmDaK7vKNP6vUHn4Izo/aNL5Wjuc2WVdxaZjrFP1gvje2RbaRosp+le6hfh5ldWoVF6ucR1aVwbOooGwTegMd49fIMFHwIsDAMfShjShGMJBDRpnWGbfcIYKBmPy4UmPa05Cs+sfe8mvfmnPzv73wvVZ5sWq0zr9LCvE8UpVuygy3795fRTQppz1Uym7nJRHDmfadBmaPCHXeMeXiF6ixAPxist2GY2qO2CFCOmTECCz100C2aPAY8FrCb/9lNaLE+h4yKhDwUdETDSCFARQuA0zpmB+XQChDvCavY1m5VlcRGF834WVjhsyx2izlG8jaO1DSz6IEfRJ56jRLfjFQB4ShDnHtZSf0r5ePx1waboy/W00QUyzMCc4u1LsueQEibeqgwa1jyqD8hqNDaUQ+8HwwRxUj9rv0rt515N0b0UKsPKp+LXdyd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(2616005)(186003)(83380400001)(26005)(2906002)(36756003)(38100700002)(6666004)(31696002)(6486002)(8936002)(31686004)(508600001)(86362001)(5660300002)(4326008)(8676002)(6636002)(66476007)(6512007)(66556008)(66946007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hDY2c4VU9tNkdYUWhKK2JmNEh1SkxsWU1sSmRub09VaUxCRnRUTkV6M2RC?=
 =?utf-8?B?cFhGWDVNRjdEUFl0aDcyMXNGVVl0ckNoWUFCd1FZNDIrdkJadnBua2t4Mmh2?=
 =?utf-8?B?TGcyZWhSNHhhVEVySHV0VWk5bVhPSG8wWnJ6cFgwQTdHY2JqLzV4QmxqT1Rn?=
 =?utf-8?B?RUVlY0gxOG9vSnFMOHRPNDBObTcxQTdyMkMyQUl3UVk3TG9DYmZ3aEZucm5M?=
 =?utf-8?B?U2YwbzgyVEF5K2FCdEhPK0JMSHZhNUFob1E0c0lpY3BhVTI3SEVCdm9JTURL?=
 =?utf-8?B?NDJzek1DZWN6UWVlaXhXdWRhYTBpL08yOVNBTkQzeW9zRGUySS9QclFJVVVj?=
 =?utf-8?B?K2gyNm8yVXNFTHF4K3A5Yk5MZmd4YUpwb01oZU0xZWhpdXFkREdyUjcxZ2pz?=
 =?utf-8?B?MVFONEFtRVk3UDMrKzZlak9iSjVETzlkWXF0MnNDTmdnM2xKNFE1NGVqb2ZX?=
 =?utf-8?B?a0lWUzZoMWsyYTh5NDJpanlZUlZHbFBNeldmNjVEdGE4M0JLR3RqeFE3eFpp?=
 =?utf-8?B?aDdMRm1EZHg3VGl3UE1JQlUzUm9NVmRRSHVINmlDSHVwYWNVaVd0L2lHaDVm?=
 =?utf-8?B?djBEc1p3THRLcEZuU2NmN3dnQVBKaGtZVnB1OTQ0bk1QMVF3My9KcHhiV1cz?=
 =?utf-8?B?SitZVmtpZkJaWXNRRDlSQjBtK2pRSi92bVlmbUpVWHhXdFlFRDdIRlZCd1U1?=
 =?utf-8?B?Zm53bmtOZTZhZmUvcFg4SEhWK3RXSWhkbkhLM2xqTVRqL2E4L1QvVlN1YW5C?=
 =?utf-8?B?SW53S3l2ZTVaSHJMSEorRW9XUHFpTnYxSmdPVHpmNEFLL0I3VWg5NWhuTUVu?=
 =?utf-8?B?NUwxR3VSb2JVWnBCVzhYa2hTT2FJU0xQdHhZcWdyUGhTWUcva2NFc04xY1hz?=
 =?utf-8?B?bWJBa2JXSVpRcHBtY1VJdFJnakFaWWlYYVdQT1lOdGJYWDdlcFZEOXNQTWFo?=
 =?utf-8?B?TkErR3hoanlvVHlIVHdPaVNHQWxpZFVvOWVmdytYNzUzVW9CMG8rTys0TEJO?=
 =?utf-8?B?V1NHd1NEa1hXYWpDQ292eklSWG9HZENMNGV6Zk52WEtsdWJySVdMSzN6aHl5?=
 =?utf-8?B?MEFnUVFOaEtwb1hZcHAyT0VVSXRSY00wRXNwNWNlTFBLTzgwdW9xdzdGSnZv?=
 =?utf-8?B?ZjhnTElUcitoUCtVNUdDcXl0dVRBelBXMWRvK2dGa1NJQTAzZUprU0lFYzJo?=
 =?utf-8?B?bXZTblJaM3JGNzFUOU5sSkc0NHl1by9PSUtWVjE0MTJxTngwdEFoRGFxSlR0?=
 =?utf-8?B?UG0xVXVUMVdBaVNwNFdrK1JsK2VpMXVlaVVBSzBNR1RjZ1cvQkxYR2Y4OXFv?=
 =?utf-8?B?aDU5TTNPeW40MHJrTUpYdjlpc01mME5OVndQVi9rWWhtQUFxWjFUeHRkamkx?=
 =?utf-8?B?d2IrQWVza1J4KzBHZ0NLbUNCNGdiOXRPMS9rQ0l6ZUJtVytPUW5BdU4vMGtw?=
 =?utf-8?B?OStBbDB4Z3ViNWR0V3ZKNmtJU05KRWUyRDNITlJ6RXRLNllkYnRQZW9ZN0R4?=
 =?utf-8?B?RlpIQ2F5V3Flemx6UmJMK29LbHZaV0pNYmJ5aHl6Mkc3c2RoeS9KeUQ2NTVa?=
 =?utf-8?B?UERvaGlPQ1N2emNMQ3ZwYmlVTUxsV21aV29mS2ZUL2pKbVBvQnpmLzFESGZs?=
 =?utf-8?B?ZkdtWjhzbndldWorWTlPaGxzVGVZYXl4K0hIdXZOYTVVZzludW55UnJhdG8x?=
 =?utf-8?B?eHNSWmRDbGpnbHlZK2RjamRvTm10cXVidG1aMlBzRnZyamtqOTY3YjB6bFpk?=
 =?utf-8?B?bUJYT3QzT2E5NCtPTXBVeWt0OFNnYWp2dVdFeDE0YkdVN0NTdm1zMm5RK281?=
 =?utf-8?B?Q1Nvc2RaRzNXeGJIdFR1VE56Skt4TitpUWYzVHcwb2FjdGRGK2E4NU05QVpP?=
 =?utf-8?B?NGFGMFZ5Z2s3bHBFcitEV3RoV3d5T2Nraml2VWJrN01EQzJ4Umh2eGNiaGNr?=
 =?utf-8?B?SkFjWVBxNjgxUzFMbFdhSTB1NGpTV0hhNHFvWS9SNXFlN0c0VXk5L1o2OTZr?=
 =?utf-8?B?TlZQdGo4TUF4QjFseW9pQmZ6YW40Nkk1VitsdGJKcFd3dGVzeXUzdFZ5VDNB?=
 =?utf-8?B?N0EwRDVJeFVkaDI0UlhmQlFkSjA3ZWhodWpCanlrdVZiTm52d1M2bW5uais2?=
 =?utf-8?B?Ym0wWGd1ZExPSHZweTVFVlMxUk4veTkxbTFKclltRkVtZFpwT1lUV3lTUTNY?=
 =?utf-8?B?RlZKNXVyL1ZSWG5WK1ZYdURzTEh3Mmp3L3hveUVlb2xkR2oxdzN3K2JsRUUw?=
 =?utf-8?B?QTFXdUVtT1V1ZFdxUDQ4UFJRcTJBdzh3STZPbGpucjBFMW9UWXRTVStWN2Z1?=
 =?utf-8?B?ZFBySytDRlBoWWNCK1ZmNStxdWdadkhCSE9qT2p5RkFxaGFpYU5TUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaa022a-b558-4e73-c4ce-08da13bd8269
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 08:56:28.7031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9VW/lg+p0h/MgSgD8vYrw3qJBU6rGWuVi7VTTLybXWKC6aSpZ7zu/f0hYu91nPQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1229
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Kenneth.Feng@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Arthur,

apart from blacklisting amdgpu I generally advise to SSH from another 
computer into the affected system if you have a problem like this.

Additionally to what Evan said I suggest that you enable 
CONFIG_LOCKDEP_SUPPORT in your kernel configuration. This will yield 
warnings in your system log in case of deadlocks or accidentally 
forgetting to unlock something.

Regards,
Christian.

Am 01.04.22 um 10:49 schrieb Arthur Marsh:
> Hi Evan, this is what was logged (filtering for drm and amdgpu) when I
> blacklisted amdgpu then manually did:
>
> modprobe amdgpu si_support=1 gpu_recovery=1
>
> Apr  1 18:31:14 am64 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.17.0+ root=UUID=39706f53-7c27-4310-b22a-36c7b042d1a1 ro amdgpu.audio=1 amdgpu.si_support=1 radeon.si_support=0 page_owner=on amdgpu.gpu_recovery=1 udev.log-priority=info rd.udev.log-priority=info
> Apr  1 18:31:14 am64 kernel: [    0.059624] Kernel command line: BOOT_IMAGE=/vmlinuz-5.17.0+ root=UUID=39706f53-7c27-4310-b22a-36c7b042d1a1 ro amdgpu.audio=1 amdgpu.si_support=1 radeon.si_support=0 page_owner=on amdgpu.gpu_recovery=1 udev.log-priority=info rd.udev.log-priority=info
>
> Apr  1 18:33:43 am64 kernel: [  245.724485] ACPI: bus type drm_connector registered
> Apr  1 18:33:44 am64 kernel: [  245.945020] [drm] amdgpu kernel modesetting enabled.
> Apr  1 18:33:44 am64 kernel: [  245.945140] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> Apr  1 18:33:44 am64 kernel: [  245.946413] [drm] initializing kernel modesetting (VERDE 0x1002:0x682B 0x1458:0x22CA 0x87).
> Apr  1 18:33:44 am64 kernel: [  245.946423] amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
> Apr  1 18:33:44 am64 kernel: [  245.946448] [drm] register mmio base: 0xFE8C0000
> Apr  1 18:33:44 am64 kernel: [  245.946451] [drm] register mmio size: 262144
> Apr  1 18:33:44 am64 kernel: [  245.946642] [drm] add ip block number 0 <si_common>
> Apr  1 18:33:44 am64 kernel: [  245.946657] [drm] add ip block number 1 <gmc_v6_0>
> Apr  1 18:33:44 am64 kernel: [  245.946660] [drm] add ip block number 2 <si_ih>
> Apr  1 18:33:44 am64 kernel: [  245.946663] [drm] add ip block number 3 <gfx_v6_0>
> Apr  1 18:33:44 am64 kernel: [  245.946666] [drm] add ip block number 4 <si_dma>
> Apr  1 18:33:44 am64 kernel: [  245.946668] [drm] add ip block number 5 <si_dpm>
> Apr  1 18:33:44 am64 kernel: [  245.946671] [drm] add ip block number 6 <dce_v6_0>
> Apr  1 18:33:44 am64 kernel: [  245.946674] [drm] add ip block number 7 <uvd_v3_1>
> Apr  1 18:33:44 am64 kernel: [  245.990113] [drm] BIOS signature incorrect 20 7
> Apr  1 18:33:44 am64 kernel: [  245.990146] amdgpu 0000:01:00.0: No more image in the PCI ROM
> Apr  1 18:33:44 am64 kernel: [  245.991510] amdgpu 0000:01:00.0: amdgpu: Fetched VBIOS from ROM BAR
> Apr  1 18:33:44 am64 kernel: [  245.991516] amdgpu: ATOM BIOS: xxx-xxx-xxx
> Apr  1 18:33:44 am64 kernel: [  245.991539] amdgpu 0000:01:00.0: amdgpu: PCIE atomic ops is not supported
> Apr  1 18:33:44 am64 kernel: [  245.991841] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
> Apr  1 18:33:44 am64 kernel: [  246.045705] amdgpu 0000:01:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
> Apr  1 18:33:44 am64 kernel: [  246.045719] amdgpu 0000:01:00.0: amdgpu: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
> Apr  1 18:33:44 am64 kernel: [  246.045736] [drm] Detected VRAM RAM=2048M, BAR=256M
> Apr  1 18:33:44 am64 kernel: [  246.045739] [drm] RAM width 128bits DDR3
> Apr  1 18:33:44 am64 kernel: [  246.045825] [drm] amdgpu: 2048M of VRAM memory ready
> Apr  1 18:33:44 am64 kernel: [  246.045829] [drm] amdgpu: 3072M of GTT memory ready.
> Apr  1 18:33:44 am64 kernel: [  246.045854] [drm] GART: num cpu pages 262144, num gpu pages 262144
> Apr  1 18:33:44 am64 kernel: [  246.046180] amdgpu 0000:01:00.0: amdgpu: PCIE GART of 1024M enabled (table at 0x000000F400900000).
> Apr  1 18:33:44 am64 kernel: [  246.084159] [drm] Internal thermal controller with fan control
> Apr  1 18:33:44 am64 kernel: [  246.084180] [drm] amdgpu: dpm initialized
> Apr  1 18:33:44 am64 kernel: [  246.084264] [drm] AMDGPU Display Connectors
> Apr  1 18:33:44 am64 kernel: [  246.084268] [drm] Connector 0:
> Apr  1 18:33:44 am64 kernel: [  246.084270] [drm]   HDMI-A-1
> Apr  1 18:33:44 am64 kernel: [  246.084272] [drm]   HPD1
> Apr  1 18:33:44 am64 kernel: [  246.084274] [drm]   DDC: 0x194c 0x194c 0x194d 0x194d 0x194e 0x194e 0x194f 0x194f
> Apr  1 18:33:44 am64 kernel: [  246.084279] [drm]   Encoders:
> Apr  1 18:33:44 am64 kernel: [  246.084281] [drm]     DFP1: INTERNAL_UNIPHY
> Apr  1 18:33:44 am64 kernel: [  246.084283] [drm] Connector 1:
> Apr  1 18:33:44 am64 kernel: [  246.084285] [drm]   DVI-D-1
> Apr  1 18:33:44 am64 kernel: [  246.084287] [drm]   HPD2
> Apr  1 18:33:44 am64 kernel: [  246.084289] [drm]   DDC: 0x1950 0x1950 0x1951 0x1951 0x1952 0x1952 0x1953 0x1953
> Apr  1 18:33:44 am64 kernel: [  246.084293] [drm]   Encoders:
> Apr  1 18:33:44 am64 kernel: [  246.084295] [drm]     DFP2: INTERNAL_UNIPHY
> Apr  1 18:33:44 am64 kernel: [  246.084297] [drm] Connector 2:
> Apr  1 18:33:44 am64 kernel: [  246.084299] [drm]   VGA-1
> Apr  1 18:33:44 am64 kernel: [  246.084301] [drm]   DDC: 0x1970 0x1970 0x1971 0x1971 0x1972 0x1972 0x1973 0x1973
> Apr  1 18:33:44 am64 kernel: [  246.084305] [drm]   Encoders:
> Apr  1 18:33:44 am64 kernel: [  246.084307] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> Apr  1 18:33:44 am64 kernel: [  246.135615] [drm] Found UVD firmware Version: 64.0 Family ID: 13
> Apr  1 18:33:44 am64 kernel: [  246.137371] [drm] PCIE gen 2 link speeds already enabled
> Apr  1 18:33:44 am64 kernel: [  246.674277] [drm] UVD initialized successfully.
> Apr  1 18:33:44 am64 kernel: [  246.674849] amdgpu 0000:01:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 5, active_cu_number 8
> Apr  1 18:33:45 am64 kernel: [  247.008964] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:01:00.0 on minor 0
> Apr  1 18:33:45 am64 kernel: [  247.068412] fbcon: amdgpudrmfb (fb0) is primary device
>
> The monitor still went blank but the magic sysreq sync and boot worked,
> allowing capture of the above log but nothing after the line above.
>
> Regards,
>
> Arthur Marsh.

