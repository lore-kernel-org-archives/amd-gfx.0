Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D7CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4B110F06F;
	Fri, 28 Jan 2022 14:50:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0003310EF65
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe46wJb0zrXb1kdD1lDTC+O7zLeB5hn8pRqs6NPFL8q61qk23aRqq0fImRjjNibrstKNwWqtn5qSZPnjDWknZro1swXVGvuJGyQPv4r5V8eD/nQDEltb0d3oBt3BV8CV39ihsGLQuYPBC08VAd+fOUu5UhDlLqTA5Nfi4RvdjYJvsVrnssTm4ZpMcnPd8kr427gjMYuZaKk3omeaNBIG9C+x91wr5zMrNaLRXs8S15D19KQgGUykc5v0KkbDihplRIHyC3O05cAkQW3qSqmYmaKXiC1nkbmqqbOlE8mCnLHtCFvFzaLGvKT2Et2l1L6hgWqPedkAl8ac3p1O6PCFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRHUV2fctYprWIReq4uof8akLwQcJAb90VjDoYMrGoY=;
 b=NHck3zrJKmSt1i/W6Dfuoi6Xk/0hsuIXjuic6DM7vUjFrftfEDPZq2vPhXDYeVkYTCaFtAi/v17fIoOSP8GYIqQaUFjpPFcrDFiBsDbM1VlLObWsMo+vcOp5fE+CIi++MUfCTFoXgnTu0NUwVbjYjSR6xvFlm3GbqnzsLeXBFAy6R6gfTcAxPYGq+VtZsJk7eKK+wK/QdgEfeSbgDI3rjDhp+A4bPCltTWkEIU5n1WZXL14g625r6CTxAbF9xZ93vADVugTqWtMtJAgGHIqrKDlEJW5M9GzfiDqtLdAYgkBWKDPIKmQ/iEyAnDfiYxHBr/KwHTraOGC/PB5qzQm86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRHUV2fctYprWIReq4uof8akLwQcJAb90VjDoYMrGoY=;
 b=0Ql+wv0r+YXdSOZkNU5BOZe7J2HZ/sIaUAB4zYQ/NAJsQo+hZ0UxkVP9DO9nhRSHJnMa95TnsqMOoJtv7tTM5Y9zFQfYXkL+myQCVlpUJbyAWuzKk0poGaBv9kCgx2NV5NO8zNOzMMI8rAcnRSuTs1DBh0vCZomJrjCQ/ECxetw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:50:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 14:50:09 +0000
Message-ID: <c2762c2f-d467-5d5e-7b24-2a0cafaac19d@amd.com>
Date: Fri, 28 Jan 2022 09:50:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
Content-Language: en-US
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220125100321.450194-1-tianci.yin@amd.com>
 <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
 <b5fab406-062f-1fdb-832b-1ba0249e1e10@amd.com>
 <DM4PR12MB52949E3762DF92C8C747ED8A95209@DM4PR12MB5294.namprd12.prod.outlook.com>
 <c7a7d79c-c59e-51ed-07fc-22d9b57c1271@amd.com>
 <DM4PR12MB5294D2C47F12FC897406884295219@DM4PR12MB5294.namprd12.prod.outlook.com>
 <1f6ae3fe-5463-cf80-063a-2c8a500b9b2a@amd.com>
 <DM4PR12MB5294035B7A2685C9A1EBBE1895229@DM4PR12MB5294.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM4PR12MB5294035B7A2685C9A1EBBE1895229@DM4PR12MB5294.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58fc4295-0c84-4856-e601-08d9e26d7ada
X-MS-TrafficTypeDiagnostic: PH0PR12MB5497:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5497E2194184F0B22E0B676E92229@PH0PR12MB5497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaca16O7m9WERh2wQPvb1km1vg1f73vRAaTZ/syljKxCpcWLpAdl2o5QQ6QWDv+L17QmNE1TuHaVZiceL9jVEu0SjqTHu8VEqK2eO5Fmyphg6MUcom7LMb09Rv1UbK2mtPbzHIminUZiRn3Sf3NJxq/CFvgu895qYJf0IcORvImkFcHDSnYgxma7sH/ND507pIZJD8/7sXH9nPZz+pJm/PJ0wIzBd/m1u+CkjGK1aagy/jOKB5W/ZlvUFpbQj+2Xa6VKp+NMvKiNjnGMzkfWiJ+jI8ajDDLYGb6v1wN5sqCsp85zSuVhxfxb54zvMhrIHahgBJdr79vj8GHU0+j71w7S0CwqSj2jiuP+yWPLd6PHC2epYK35ajCx6gs9bNUHZEBLPEaKwBcPI4e3xVPIO+6TqRkwplKKPJUhREU3ECGOh0s7zoG8yaz4PMpjVt1hoY2CPX4Ar6ywza3jNh6N/IqOosNThQhPJnCP6K9c3jhOgZV7AQ3HY5m+Na3Wv/JEQbvFvB0vo4f3+/5nxzWoJltWmcAyyMr4MBgsj/cxmAyeisexnwLj3Xq4mCtz5t4CDfyLlaKTVTMhw7UAGjK7iakjVPuwA7O/Hx0qH3MThm0fpu3sNmxTxJX/cqemfbBGFQl1N4zyWvffbdiwTpnX1inq9WkqoH6Aj3IfXSHVXKDYVImra77kzJzb63OBJ1MgT4WwvfgF+DIcsgvNNaZR9AE5k7aKZ5nu08uxhnHoaE+Su/1RgoriKypbjArMIBkl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(2616005)(66556008)(66946007)(66476007)(31696002)(36756003)(6512007)(8676002)(6666004)(4326008)(8936002)(31686004)(6506007)(30864003)(110136005)(26005)(316002)(38100700002)(44832011)(54906003)(5660300002)(508600001)(15650500001)(186003)(86362001)(6486002)(2906002)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEg5ZVBLYW5vZWF1VlRHVDZVclJ6RCtqVjFUcUhhSitSRFE5dzhoUkR0ZktC?=
 =?utf-8?B?Z0NVS3FYditVcVEvZERUYmplUU9uR3k0ejZ6MEhYK1oxS2loQ2ptRnRPTUxW?=
 =?utf-8?B?bzdDWFFsSkFkVUJ4bnhyaHB6RTNFTzFWYlJCQWw5NVBhOGlJeVZKNml1UktE?=
 =?utf-8?B?bmhMb042WEVmb0I0aHFacFlDUnRFZEsrdVlXVHZEU01lSkVMUzVqSURXdDZC?=
 =?utf-8?B?aXdJb25YVUo4Mm5nYkloUlBxMU5LVEFoSXRBVXBaRGpEYlJtbUNjZW11ZzFP?=
 =?utf-8?B?RzFjc05WcXFSdithVklBakxKY2lJdnJCODQ4dnJWWVRYa1RXT3R1MkgzWHNw?=
 =?utf-8?B?cHZQYXROUDB6Tlh4cGZvYzZXQ2xtd0hrWXhBSmtTNjRJLzJZRExsWElhRktP?=
 =?utf-8?B?ZDYzNFNVMzd2Y213cGFQdmh0OE9VVnpiYzdsZCtseVFhUzI5bnNPWFVpcWt1?=
 =?utf-8?B?NllrV3lJU09uQlhuaEM2Z2M4dGQvZXFWK3RkWU9tais5d0R6U0VsdDVkaDli?=
 =?utf-8?B?VnFLK2gyaEd1YXRQMFd0V1lsSVFuZWpMOFBiS1hFYzF4N1ZrNC9HR1pxdHJH?=
 =?utf-8?B?M2llQ3lzYmhDd2h5czdoaUtmYkhqb3VHTnFvMnZFeVdWK3ZYWEhDTllVTVlP?=
 =?utf-8?B?aTdNRm9UeTBmY0tBMndvaXhhOFBML1Evb3E4T2FhWk5tMjZYc3lOblJ1S3ZZ?=
 =?utf-8?B?OEM2dHFNWjBEQzNkemRvdUJLdk9lSmE1M2hoNEpGTHpwVWdHTWYvSnlpOUZv?=
 =?utf-8?B?ZzhNZUJqN3dqK3pYanZIazlXcmdJN3FDd3kyOVNlbDRCLzROMVlhZHpYUnVC?=
 =?utf-8?B?Mlkya3hBK245bnFud1l4MFIwWjlNelcrQmlUc3dvWTJ3SUVaRWJwNUsvWldo?=
 =?utf-8?B?S0thZWFPRXlZU1dWejh4a0xoMmtIeEtJbG1MNVBJcEt5Nm92a3l2YzZoZUhY?=
 =?utf-8?B?MVJ4RzhQYXI3eVRvb1QyckRoc3ZwdUJ6RWdOSXk4N3N3VDR1WmhXdXA2OVVZ?=
 =?utf-8?B?VHFNdlJEd05pWGhIVTNiUFV2MUFrZTNGM1ltcnM5S0lqTXFGc2pWR0VRRmVs?=
 =?utf-8?B?emhvL3YxOEkxZmJ1WjI3WmZWWHRZZjFvUXZKb0k0bUtZaVZhak5iRHYrNTZy?=
 =?utf-8?B?aU94Y1V4ZWtmYlcrZDUyM0hzWndpNk13Q2RkQW9xa3dvZWxqRmdJSFROT3hq?=
 =?utf-8?B?VkNIWUxtQWFwMU5OUWxSdTBRUkZJNXYzZFUreHdZYk9nSzUyN2p1TDlZRU1Y?=
 =?utf-8?B?L1AxcmJxdFRiM3E3NnhFc29YRENNbmRleXZreHU0aVEzVktROFlTSG0yL3JS?=
 =?utf-8?B?TVNINTkvd1JHblNaak5PZExPNlpTT1VweWFoWVcwZlltU2h6WUsrRzFlaG9F?=
 =?utf-8?B?SXJVb1FvNjRocUxoRUdTNXM5VWZldWR2cDNXTlpVQ3NSNTN5RDlpVXNzU3pP?=
 =?utf-8?B?R0FybER2a3NqYTRZYnlsUFBWcVdIMkVxVHR1U3oxMWlzM0JVcVlXdXJyUkto?=
 =?utf-8?B?eEZBSXk4b1Z2STJ1bkdzWEJER0xuNENVbk1EbW9DNk03VFJER2N3cWgyYm1l?=
 =?utf-8?B?ZDdTZDVaM1lLU25uOWpYWlFUSE1UdWNqUDd5Umt3UllHSmpsRUx6RTZJSjk1?=
 =?utf-8?B?bit4WlJaaHM1SXpZZVhpUGNlK1A0OGxaUzUyZUtzM2hsQk9oMXpnWUEwSmdX?=
 =?utf-8?B?UVV3WHFHYS9PWjhhZTJYbEd5QXVER1BsQlk3UUE2S1FzZ3l6U0VpdVFpNG94?=
 =?utf-8?B?K3l0a0NsYmZLR3pURWROVkZRUXhST2JYZG9XNUFwQ2pZRGt6QzVDejdRQVdQ?=
 =?utf-8?B?SVp6clZkYXJHMU0yNzhUbWlNM2hCdnJlT1gwVGdVeWNYdUlBT1VEWFFoRFEy?=
 =?utf-8?B?RExlZGVuZHBkcWxBcmxMcXJHcmJCSE5ZblVOUjQxaUxHamFseUV3NG0xT2hG?=
 =?utf-8?B?UndPSjB3UjB0NzMxVmhhN0hWV3ZxV0FQbnRDM3E5U1Z5Q0NHdGFkYzhOeSt3?=
 =?utf-8?B?dFRNSEZWakpnR3ZXVER5MlZXUkxHNk5LZDBKR2ZqOG9wWE12OUNZL29HVUFk?=
 =?utf-8?B?bUhSODUyNzBQUmJzcGR3ZkI2RXYvdTJ3OW5WY2tOOHhHZ0M5TnMwNzdkRnd5?=
 =?utf-8?B?ckVQbWl4NDJEWHptTTFCNkVVWWFzZVpvVER6WkhCMzY1SEVsR0hDandBMUpI?=
 =?utf-8?Q?0ZAA+3923u+Eney/ZGuR4sE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fc4295-0c84-4856-e601-08d9e26d7ada
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:50:09.1520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20T8vqxyCk07EwPSKmhcAgOlLKSlQg2ueMJuTL/RFKYaf5f7tpn4fCN4yz4Utn+ikqnCv8eggc9fz/oA6VjRyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I see, thanks for clarifying. So this is happening because we unmap the 
HIQ with direct MMIO register writes instead of using the KIQ.


I'm OK with this patch as a workaround, but as a proper fix, we should 
probably add a hiq_hqd_destroy function that uses KIQ, similar to how we 
have hiq_mqd_load functions that use KIQ to map the HIQ.


Regards,
   Felix



Am 2022-01-27 um 21:34 schrieb Yin, Tianci (Rico):
>
> [AMD Official Use Only]
>
>
> The error message is from HIQ dequeue procedure,  not from HCQ, so no 
> doorbell writing.
>
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.477067] Call Trace:
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.477072]  dump_stack+0x7d/0x9c
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.477651] 
>  hqd_destroy_v10_3+0x58/0x254 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.477778] 
>  destroy_mqd+0x1e/0x30 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.477884] 
>  kernel_queue_uninit+0xcf/0x100 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.477985] 
>  pm_uninit+0x1a/0x30 [amdgpu] #kernel_queue_uninit(pm->priv_queue, 
> hanging); this priv_queue == HIQ
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478127] 
>  stop_cpsch+0x98/0x100 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478242] 
>  kgd2kfd_suspend.part.0+0x32/0x50 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478338] 
>  kgd2kfd_suspend+0x1b/0x20 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478433] 
>  amdgpu_amdkfd_suspend+0x1e/0x30 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478529] 
>  amdgpu_device_fini_hw+0x182/0x335 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478655] 
>  amdgpu_driver_unload_kms+0x5c/0x80 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478732] 
>  amdgpu_pci_remove+0x27/0x40 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478806] 
>  pci_device_remove+0x3e/0xb0
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478809] 
>  device_release_driver_internal+0x103/0x1d0
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478813] 
>  driver_detach+0x4c/0x90
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478814] 
>  bus_remove_driver+0x5c/0xd0
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478815] 
>  driver_unregister+0x31/0x50
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478817] 
>  pci_unregister_driver+0x40/0x90
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478818] 
>  amdgpu_exit+0x15/0x2d1 [amdgpu]
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478942] 
>  __x64_sys_delete_module+0x147/0x260
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478944]  ? 
> exit_to_user_mode_prepare+0x41/0x1d0
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478946]  ? ksys_write+0x67/0xe0
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478948] 
>  do_syscall_64+0x40/0xb0
> Jan 25 16:10:58 lnx-ci-node kernel: [18161.478951] 
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Regards,
> Rico
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Thursday, January 27, 2022 23:28
> *To:* Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wang, Yang(Kevin) 
> <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun 
> <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> The hang you're seeing is the result of a command submission of an
> UNMAP_QUEUES and QUERY_STATUS command to the HIQ. This is done using a
> doorbell. KFD writes commands to the HIQ and rings a doorbell to wake up
> the HWS (see kq_submit_packet in kfd_kernel_queue.c). Why does this
> doorbell not trigger gfxoff exit during rmmod?
>
>
> Regards,
>    Felix
>
>
>
> Am 2022-01-26 um 22:38 schrieb Yin, Tianci (Rico):
> >
> > [AMD Official Use Only]
> >
> >
> > The rmmod ops has prerequisite multi-user target and blacklist amdgpu,
> > which is IGT requirement so that IGT can make itself DRM master to
> > test KMS.
> > igt-gpu-tools/build/tests/amdgpu/amd_module_load --run-subtest reload
> >
> > From my understanding, the KFD process belongs to the regular way of
> > gfxoff exit, which doorbell writing triggers gfxoff exit. For example,
> > KFD maps HCQ thru cmd on HIQ or KIQ ring, or UMD commits jobs on HCQ,
> > these both trigger doorbell writing(pls refer to
> > gfx_v10_0_ring_set_wptr_compute()).
> >
> > As to the IGT reload test, the dequeue request is not thru a cmd on a
> > ring, it directly writes CP registers, so GFX core remains in gfxoff.
> >
> > Thanks,
> > Rico
> >
> > ------------------------------------------------------------------------
> > *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> > *Sent:* Wednesday, January 26, 2022 23:08
> > *To:* Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wang, Yang(Kevin)
> > <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> > <amd-gfx@lists.freedesktop.org>
> > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun
> > <Guchun.Chen@amd.com>
> > *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> > My question is, why is this problem only seen during module unload? Why
> > aren't we seeing HWS hangs due to GFX_OFF all the time in normal
> > operations? For example when the GPU is idle and a new KFD process is
> > started, creating a new runlist. Are we just getting lucky because the
> > process first has to allocate some memory, which maybe makes some HW
> > access (flushing TLBs etc.) that wakes up the GPU?
> >
> >
> > Regards,
> >    Felix
> >
> >
> >
> > Am 2022-01-26 um 01:43 schrieb Yin, Tianci (Rico):
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > > Thanks Kevin and Felix!
> > >
> > > In gfxoff state, the dequeue request(by cp register writing) can't
> > > make gfxoff exit, actually the cp is powered off and the cp register
> > > writing is invalid, doorbell registers writing(regluar way) or
> > > directly request smu to disable gfx powergate(by invoking
> > > amdgpu_gfx_off_ctrl) can trigger gfxoff exit.
> > >
> > > I have also tryed
> > >
> > 
> amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PROFILE_COMPUTE,false),
> > > but it has no effect.
> > >
> > > [10386.162273] amdgpu: cp queue pipe 4 queue 0 preemption failed
> > > [10671.225065] amdgpu: mmCP_HQD_ACTIVE : 0xffffffff
> > > [10386.162290] amdgpu: mmCP_HQD_HQ_STATUS0 : 0xffffffff
> > > [10386.162297] amdgpu: mmCP_STAT : 0xffffffff
> > > [10386.162303] amdgpu: mmCP_BUSY_STAT : 0xffffffff
> > > [10386.162308] amdgpu: mmRLC_STAT : 0xffffffff
> > > [10386.162314] amdgpu: mmGRBM_STATUS : 0xffffffff
> > > [10386.162320] amdgpu: mmGRBM_STATUS2: 0xffffffff
> > >
> > > Thanks again!
> > > Rico
> > > 
> ------------------------------------------------------------------------
> > > *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> > > *Sent:* Tuesday, January 25, 2022 23:31
> > > *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yin, Tianci (Rico)
> > > <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
> > > <amd-gfx@lists.freedesktop.org>
> > > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun
> > > <Guchun.Chen@amd.com>
> > > *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> > > I have no objection to the change. It restores the sequence that was
> > > used before e9669fb78262. But I don't understand why GFX_OFF is 
> causing
> > > a preemption error during module unload, but not when KFD is in normal
> > > use. Maybe it's because of the compute power profile that's 
> normally set
> > > by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.
> > >
> > >
> > > Either way, the patch is
> > >
> > > Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > >
> > >
> > >
> > > Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):
> > > >
> > > > [AMD Official Use Only]
> > > >
> > > >
> > > > [AMD Official Use Only]
> > > >
> > > >
> > > > the issue is introduced in following patch, so add following
> > > > information is better.
> > > > /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/
> > > > /
> > > > /
> > > > Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> > > > /
> > > > /
> > > > Best Regards,
> > > > Kevin
> > > >
> > > >
> > ------------------------------------------------------------------------
> > > > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > > > Tianci Yin <tianci.yin@amd.com>
> > > > *Sent:* Tuesday, January 25, 2022 6:03 PM
> > > > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > > > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Yin, Tianci
> > > > (Rico) <Tianci.Yin@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> > > > *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod
> > > > From: "Tianci.Yin" <tianci.yin@amd.com>
> > > >
> > > > [why]
> > > > In rmmod procedure, kfd sends cp a dequeue request, but the
> > > > request does not get response, then an error message "cp
> > > > queue pipe 4 queue 0 preemption failed" printed.
> > > >
> > > > [how]
> > > > Performing kfd suspending after disabling gfxoff can fix it.
> > > >
> > > > Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
> > > > Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > index b75d67f644e5..77e9837ba342 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > @@ -2720,11 +2720,11 @@ static int 
> amdgpu_device_ip_fini_early(struct
> > > > amdgpu_device *adev)
> > > >                  }
> > > >          }
> > > >
> > > > -       amdgpu_amdkfd_suspend(adev, false);
> > > > -
> > > >          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > > >          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > > >
> > > > +       amdgpu_amdkfd_suspend(adev, false);
> > > > +
> > > >          /* Workaroud for ASICs need to disable SMC first */
> > > > amdgpu_device_smu_fini_early(adev);
> > > >
> > > > --
> > > > 2.25.1
> > > >
