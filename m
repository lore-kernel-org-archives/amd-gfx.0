Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D90C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 19:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB4710E5EB;
	Mon, 24 Apr 2023 19:56:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE2110E5E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 19:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFOGfvmBfsi1wKHzKegHyFO3JYS/IfmxHYmXTaWPgiFsU3xNtzjYKfNCOYWNxLZ+U9190Jp7oXIXoO7l8/JvbTiQtXHhJVLUjyOkQmhyHBHxMf1SA6Da95ekl5jzMprTT5A7jTUlTxbA52nfQyTI7hVf7Cxib+I/QNs8ztRc/trGHo0VAootEww7YKPUDhFu9Ih4MpFLPIrMl18gbwigaxvDUV/WI3yAXriO6HfeHms5cEoJpzB/UshqGhLP0VeaEgPRfE77mG5sj6UpE9Q0hLhh2TGtUYQ7qonnP3RqIY1K2vaROYRKk4gVLTox0lHQogAOOgibBNQeHRguVUI5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4wnmkV+FVF6f+kKsp0453X+xquMBSIMCsDtLSKZGU4=;
 b=A8tidbtMFJdpC//yU/6AE1I8BxNswXRHU9de1SfY24brvB3RH0e604bBsVxMFM455v8FFG59DrUf3dXTQma5eGBRiqdy4v/A1DYhCyA5t/r0bBGcBzK77f21bQqN9GiSeaX9gUC0ZPt1da/oD6b5LXcPq4BBp2Cs1R5/KzMi68ukolx7vE4m4UGI6CbTOQjfLvihAsb4YBqjHG6h36eugi6+kH6EiOx4fdInj8hm5tKWyDIk9XF6Lp3RngPbFYwhEpodKYo5BDvCTAM1jjPAGa8pj/SLu8ct2B96wkxv1lAXxQyBtWe9HwY2AHiu5x9IO5Nity71zUDh4a/SNBsnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4wnmkV+FVF6f+kKsp0453X+xquMBSIMCsDtLSKZGU4=;
 b=y2LoX/yREmlxHzpX551WxaPJegJW//s6zaeuHClIZaLTR94tyPOIsLbKcORxSmkNrXJe3i6orHJybikGPyoTWGrM7efgG10ApsvPjMa3qgMN2caadNEJUKrnu9Tmc/wxXWCUwBhkZp1F9X3jpdaDkBK5v5eE4Z2nCW+GhjFpWVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 19:56:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 19:56:32 +0000
Message-ID: <4980a1b8-cccd-6d08-a95f-0d7af7b15878@amd.com>
Date: Mon, 24 Apr 2023 15:56:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-9-shashank.sharma@amd.com>
 <2808cded-f913-58fa-a026-6887445ef37f@amd.com>
 <0c0fb5c0-1183-c4b3-272d-fe153faefa28@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <0c0fb5c0-1183-c4b3-272d-fe153faefa28@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:610:50::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9df1f1-aa73-428f-6315-08db44fe0072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeIuJjV6WvVdPY3hNSV2svQMZdxXmmydQUyV1v8ya2b7hSQnXTFuDbIIad01vr0U8dhtgqwwBdqCdOun/yttISFPKMbQ55ucd5gK68a630dXbEICQC8UnUe6WwkGZmmDpBV4UgdRYwcya7n+fdBU7G2YOGAQAocbNF6QUr3Zrp2cXz23WEGDT/1RKOA5CjBcdGoD+AS+z0B4CLiae/9xUqBfMV/LBrAIMvHFNBQnkZcxdr5a0kqX6SkFidsapoyl2rzKTToVaJcuSSLUyH7uNNBgfNFxH33jSYXGcadqaPMuElRw50bExZXm9521n0cJELyq5DY0aQDCQtUIgxKcnZ98zqohUpF0rtTCy8OK4Gvoalo9N2h9G/XYduIqyZ8t+kjdetmzSzZz4MVLMRENCXaf9R8+W2NWiMVaesvEDHKfD9HLbGo4yeBd++H91rRj2w3lTr4KPWmgySKKGM63DpJA4YI/uheyJfDurz5mHo+o+TaG9OYLVrWG+93Ds8uMGfy0FItk2lxxVV2VmaJPbMFXVwQk1p4KZba9XDIBF3ZdVrtAX85csofxlEwyJid9RAZMzMHoPt85tAQ/bcL42eOpjtvVpiW2hlka6v4FpAETZ7fgK8gc+MHjN3aDmyZmFF1kj9/Oh+VTnOP+8YHwcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(44832011)(6512007)(26005)(6506007)(53546011)(8676002)(8936002)(4326008)(66476007)(66556008)(66946007)(54906003)(316002)(36756003)(41300700001)(478600001)(6486002)(6666004)(5660300002)(38100700002)(31686004)(86362001)(2906002)(4744005)(2616005)(31696002)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5sRDRHTVQzL01WbDNJcDNTQjV3VC9mYm0vM2IwZzByQ1NVcXhDMTNlUFdJ?=
 =?utf-8?B?SnpSdmdIb2p4OU5kajB4QUwxbzBrUEx1cXdQU2tERTZqV2JzY3MwUm5rVGZ2?=
 =?utf-8?B?a2JjKytqT1dnRjVQR2JjWnpFMlZaTVljSzZML3VPcEc1TnRXU3hPNVV1alE0?=
 =?utf-8?B?ZHk1bUxUcEhkdXg4Z0daQUlEdlFtcmVFNDFxcmxHTk5VWmRrM2wxV2lHb28v?=
 =?utf-8?B?ZGpiMGs4bWNvWG9KSzUvelhCWks0OHVocVdSNkROd1cyQjZBbldZeFZjMXVE?=
 =?utf-8?B?c0g5aXZVSFFaTWZZY1MrbjFvTjIrMG8yQXViVWRBeUZiZ2hQQnltUXVSTSs5?=
 =?utf-8?B?V3hIK3NNWjE2c2VuaGVYQ1c0TzRqSlRibmhmTGNUZncxL0ZUbnlveXhvNmJw?=
 =?utf-8?B?dFdDeHR2NnplV2R3Ri8zeDRRT0UrRmFKZWhGQ2VoaWpveW82dEFDYzdwbUZV?=
 =?utf-8?B?eHVjOUFiUEZMNmZuNDdFZHUxenlXbjY5VnhzLzdmdlgzT0s0T1FCUlg4YytE?=
 =?utf-8?B?b3MxV3ZCZnJFWGtYemc2TXRXT3VuQnlGbW9HbUhuYmcxdGZuL09TZWlXczZX?=
 =?utf-8?B?bVZBaUt6Y2UwWVZsUlg2djRqN0o4Vm13aXFQTmU4SzJIUDJPcmlmdU5xVUFV?=
 =?utf-8?B?akJ3R1ZTT3RQUVNySUxycnN1MC93eXFSZWpqYzlHQ3dBN3JLNENCaUZFTG5h?=
 =?utf-8?B?MDNYZlltU0ZmR2t2Z3lUWStWc1EwaXNBZ3Z6cUU2a0I3aEVSOXhNQkRySE9t?=
 =?utf-8?B?T0FFNFhWWG45YnJEVUVvRXJiVFBlendFeTg2VytKYnMwdXFCbnNvNGNEUVpR?=
 =?utf-8?B?bXFqMy9kUEozbmZqN3greHBHL3YvRXRHbWhsemdDTERjNy9GQjEwSTlxWm5s?=
 =?utf-8?B?V3c5UnRUaGMyM0ZNT0tZZG1kRmVtV3hqUS82OXB2VGNqZTZFbjdhTXAySk13?=
 =?utf-8?B?VkFzN3hCZG9wVVdkdGRlcnN1YjZtMHJLME91NGJweUVCa2N6a21MZXVwUHpP?=
 =?utf-8?B?WnczbFkyTFNZejYzbnV5M3NVcDFaZjJHZ2hucG1GanhoSGE5NDl0OHB3aGRU?=
 =?utf-8?B?R3RrK0xJS00zbjhRSnVRTDI3b0UzWThsK0hwbkN6L1o0TUwyeE5tNHVWZnFl?=
 =?utf-8?B?YkZkaS8zd0tUbTM5WWxNQURCbU96SEdYdU1vM3VnMWRiby9vdHQyVk1hYnBZ?=
 =?utf-8?B?VStSOVZTeitwYmRlWFRjZllXc0Jrc2hsaFE4UjU3eGxxUlVwcW40UCtmMEJ1?=
 =?utf-8?B?NUIzZVNBcVV1dy9LYXlvb3d0MUF1ZllWenlzQ29nVzZuMFpzM1QyYXJVMFkw?=
 =?utf-8?B?QXdsalkyN05udEFSUzh0V002aUhkU0ZrZEQvV0IzRXNzMDVvNy8zQ01TU281?=
 =?utf-8?B?YWViZUpVb0tmY28vMlZHNC9GTGZOSHBzenZhVWpPMzc0TE5tWklSVnE3N0NM?=
 =?utf-8?B?TDkvY0hGNUUva3NSTlpZWVZ2VHpacWt6bGFPcTRhellLV1VKRHo1QVh3TW1o?=
 =?utf-8?B?cEVyaHkzS3B3VkkrMGU3ZlNpUFprcmc1djVvWnFwdDdXYnRONnpKMEQ5VDBq?=
 =?utf-8?B?aVdWMUxtbTVJaVoxdmVQOXNYL1dScmJ4RTd3V1I2L1lBZHZIc2REb21pNDNo?=
 =?utf-8?B?bW9PSnJvMll3UUpVS2FPUENwSkpqRW1Yd1ZOT0NzRmloaFNuQjdaa3hNNHZj?=
 =?utf-8?B?YnNOWGYxY2JRYWNJMStyMXRKSkE2TEpEQm42eW1nMit6U2pRNm05UEFwVDhZ?=
 =?utf-8?B?WXVJa3NFV1ZiS0V5SkZ6VFNTMi9aR2pjYUJ5MzRrL25tbGtDY0lUQTZrQ3Fh?=
 =?utf-8?B?Snpnc20vTllveU9GVmdvaHJMblNJSU5teWpzUGpVeWhXWjl6LzJRU0lKNHYr?=
 =?utf-8?B?QkJzREN5OTRaeFR3N3FKWUI5M3BGN1l5MnNQeEdCVVY4QmVRTHpsZW50blVC?=
 =?utf-8?B?RGt2TjJzUTBXV0l3OE9VaUc0SWZTZ0FMbmpneUZBY1ZXVWl1MUo4dVBPbnVU?=
 =?utf-8?B?ODh5SlFjY1kyamIxYy9rMUJnRDg3SmJnY0xlUnczamVIRjZjMXVjQ1liWnZv?=
 =?utf-8?B?cmM0c1Z3L1l6WWdZY3B5YklMZXFWSzFTaDFMVU5qb3hoeFhLY0dJcDBhbEF2?=
 =?utf-8?Q?FF1k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9df1f1-aa73-428f-6315-08db44fe0072
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 19:56:32.4859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9pGldDLG/bTIau3gzfsASTNE9YDPtI6sgnUUgCedF6FKN/nL7XausN7EEFzbHkmfZERnIs02gzBIabMkxLRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-22 2:39, Shashank Sharma wrote:
> - KFD process level doorbells: doorbell pages which are allocated by 
> kernel but mapped and written by userspace processes, saved in struct 
> pdd->qpd->doorbells
>
> size = kfd_doorbell_process_slice.
>
> We realized that we only need 1-2 doorbells for KFD kernel level stuff 
> (so kept it one page), but need 2-page of doorbells for KFD process, 
> so they are sized accordingly.
>
> We have also run kfd_test_suit and verified the changes for any 
> regression. Hope this helps in explaining the design.

Right, I missed that this was only for kernel doorbells. I wonder 
whether KFD really needs its own page here. I think we only need a 
doorbell for HWS. And when we use MES, I think even that isn't needed 
because MES packet submissions go through amdgpu. So maybe KFD doesn't 
need its own kernel-mode doorbell page any more on systems with user 
graphics mode queues.

Regards,
   Felix


>
> - Shashank 
