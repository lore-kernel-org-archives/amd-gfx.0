Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF367EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 20:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593CC10E350;
	Mon, 24 Jul 2023 20:04:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD85210E350
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 20:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epiMvKfNPxg4jelA24TraBJECmK7xw0EZ5NxcimWvoyejueK6zOvEtAHQ7n/uKX+zy5ii8W0y3u1ExL3TwX0MglEsjY97QztWNooDMxLZ7k+u3DSdLsQP9dNzbvY0b0E+zcbqAWxVhzN3Ty6oiWf+9Q7T8EaUDyjynx0MrDPaG1cvcBSz3urM+189gxtxHgXyIwa8lgG43oyuLtnqA4fFxLu5EzEjxEodJgndIz+h9sE5CeicKFpIVEV6VJT+eqI7HvWfzwRlfxiHsDvARj4VPMTT5diqAmV0mnW8vOjCr1c9pGA8h/T/p6qaiJd4jvMjVDhE+l6PDzX3v+cD7b5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrzN+Q94Ol85aejQ/ndU2zXiIqo5ZLUolLwLuoe7S8U=;
 b=lCVXJ81SegiP/xe+kbe/dU6j3n2Va4CH7dgZpbNSU5ZPHe7blp4xGeRHsdoxokOpv2u1dTcvVDvrnFeNdoO/Ht4C0OjUnofVvVwI29dSsEoFuStlbaXgWs+wU5jRWvM9aAEgAMB3bP5zurVl0PHTfjSp1FmLyBgO4/FwO2xoVO/UdEpp+QZ5HzT46CRc4F9pFpJECkUXDDLR8o8Bxua5PMOdMoB/igO3xZ8Af7ws55+7csj2a2jVtlMYumj7kttfX7xPp0rsQsgvayu3UCJe2w4+xgCCojwzM8NBnPnmRKFZdpiblU4Kd4X8MePXgADaSALQBCBgZ94acj/IA8wAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrzN+Q94Ol85aejQ/ndU2zXiIqo5ZLUolLwLuoe7S8U=;
 b=PzwbL2AmqDVKs+AxfKJ0LXAwAhW+bX5W/8H597otnaLusmKKvvvGRbT8SipwznyhXg+8qX8ifNFp5+LGwoG4UmKFf5Pt082kSvKf+t3AyPSTGbrtJHTSfMFMZKFoAHsc6mIjxolUZnfwn3i+nyfb0v40r0OTZa2VI7SJyijkLOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 20:04:09 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 20:04:09 +0000
Message-ID: <219fc41b-13f2-8517-1720-eb92fe02083c@amd.com>
Date: Mon, 24 Jul 2023 16:04:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Philip Yang <Philip.Yang@amd.com>
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
 <1da36164-7cd9-c2a3-a42f-558942257727@daenzer.net>
 <f8c83922-f3d4-34d8-6ae1-3112b52bcdf3@amd.com>
 <d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net>
 <0a99c609-c5c2-25fc-4ceb-52a0b4a49f29@amd.com>
In-Reply-To: <0a99c609-c5c2-25fc-4ceb-52a0b4a49f29@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL1PR12MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d87a99-ff67-4aec-7eec-08db8c81241e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3kHAJBXKScrKsNqX5s5zc8HjYq9xLTjNmNr9E0NXdtj3WC7mjkEyBpALEbD+KKRnosoDpEEAQHWZ1ylEkNGnIgNt5Vev9OwMAlK0D2Fv/aV1xzZWzXkx5EXLheO8IiApFSkMXQR0bdDrEa/1BDAkJbdn1KW/b2OVSOixieCkzqosrR7GE/gG0p5xbnxQIHd141jYi2bvm1RdfmrLuTBfNwgPhs2CZelC2oH6VqHrUW/kNj2F0pX0q7/0urAcwMOcVgH3T5lmKj0KzzwDIdQuFRF4S+t5ArBXiaZ7uwlzOQFUTNSrSD2dAq0fSyjocxFNEGCRbubyN4YRfNMdRzMHUr8+SoRHl56m1NcwyDisVnusv5J/xTfieoXkLJeu3V/scwmzOPH4dPUaDOmeK1LWoy9hSXEk4pCff7KN0S907HddgUHnK9Y82k+OEBYsKiBkqDPCNrJ/UeZ+Btia20LjBBucGDkyoC7f4SFHeTews4E1dHA05qqoCdLwf5q7MjfUAXOTXaSGID9ADh2S8/N9o8BP8Eif9+zEqk8SqD48Xpr7SVBZ+cyVtOaHTf1OGFs2RAZpG+6HE11E/Dr1mLWzObvhiRTe9bWVv0JTnAoU+/dj25LT1g3PZ9ZWwmbozAV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(38100700002)(166002)(53546011)(2616005)(66574015)(36756003)(83380400001)(8676002)(8936002)(5660300002)(110136005)(478600001)(54906003)(6636002)(66556008)(316002)(4326008)(66946007)(41300700001)(26005)(186003)(6506007)(966005)(6486002)(6512007)(66476007)(6666004)(2906002)(31686004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ditTSVVkbXRJWjFRWUtWaWhaZjlKUGwwL3BKcDNjV05oUGozUUhtMmtTbEh0?=
 =?utf-8?B?ajVCMVFlTG9uRnRKRTFDWGFsRlJiUk5NYU51Z3lYNmw1OW4xSUFIVHNjZ3hl?=
 =?utf-8?B?WDY4OTUwWHBoZU9NTXdSZTB0bS9Od3RORHJZN3pQdUd2QXpRRTNudnZEcHJk?=
 =?utf-8?B?cXFROENXRHY0Y00vZXY5ZHlTQmJXci9ZeWMvQk8vR3VMVnZkRjNCbktTTmpQ?=
 =?utf-8?B?UktKSSt2aWNVZ0s4NGlsQ2RvZDl5MGNKT080QXQ1UlFlOERMMmFVU2lNL0FO?=
 =?utf-8?B?VVdqR291Tk5Kb3hIdUV1ZlhaeGtydlZIQ0tpMFVJOVVqQW5TYXlyNU8wc1p6?=
 =?utf-8?B?eWRscy9OMzN3ejI5NUxFSW05Lzc5K2ZZcHNoK2RPR2J0QlJqR1dsNzNwZmJK?=
 =?utf-8?B?TEh2KzVHdFFWNHNJMXRJMmZPOUZCU3l4ZmlNRjl6UjY2NE5jSVlhQVp2QUhT?=
 =?utf-8?B?UWtJTUhrbGlMVG96V21ncWJ5ZnpMTmxNRldBdGRCL1MxWXFmcW5qS2U4MTJI?=
 =?utf-8?B?UGM2amhlbzBDRWVYWEhVL1JBWlpnTTBYYm9EcjBMM21QTXVaZVh3NG9IUlhi?=
 =?utf-8?B?NWJrZTRTYXAxcVpIL0tESXc3eGZxeFZVU1htaGVCNk0vVDhiM3VmVXJvSU1i?=
 =?utf-8?B?U3AwMmQ5V0VUazZ4RVRwS1lFd2NMNjhlUUVGaVBUVHVzNmd2eDJpRjBocTY2?=
 =?utf-8?B?VzFoUUl5djBteFVnMGsrZlgwNnp1WDVSZkZCWndXUnhjQUM1akdTb0VLejBJ?=
 =?utf-8?B?WXZSa2Z4L1pGbUg4OHdXTHFJM2FCYXc3aFp5cWxTNjlmTzZrendZZkJVMVBj?=
 =?utf-8?B?dHZQMTJ3ai9FVHNtUElDRm5Gbm44ZnQ2QTE1eDNzeU9uRm00ZzRCS3pZa2Np?=
 =?utf-8?B?TThkSW9tenBlTjExRmFXSlJvbFRkd0pMc2puTjlpWFRuenlteTJ5MHBqeUdv?=
 =?utf-8?B?N252VWlOZEZZb2dYRkJ1d0xVZll2UWpxYkt1OHNITUluS2lZRTNhdStBMlE1?=
 =?utf-8?B?WUJMS29INk04MmZqM3NWMmo0eDdmRDFjbDFIQTF3bGxvdnlOU2hCSlhoOEVs?=
 =?utf-8?B?QkJ3QVdRUlBMTVZOMC8wTkpDOWw3V3dCeEYwdjJ2dlNjV29nTTNsNVpkaHBP?=
 =?utf-8?B?S0M5Q2pIaWFkT1RnWXQwZ1NRSlBHYUdjUGhUUE9MQnU5ZGdVWjRsTzJTOVZE?=
 =?utf-8?B?Qm5HNzdkNGJOVUZYSCtlTFBOZjc0YjhwVU1FZHNabnF0bXpUeEUrcEkrV2Vl?=
 =?utf-8?B?d2s4M1F6cG9ja1AzMU1HSWdRVDJNdFkvVVJXKzVWNnBhT3J0Y0J1TUxuS1JK?=
 =?utf-8?B?MGpiUHBjYlBDcnFtUWd4KzFBakNHZjFwYTNmUTdlays5TjNXNEx2V0JFZE5I?=
 =?utf-8?B?L29vbVVrTCs0REY4cDNOZmNNbUtRWjV5NW5YK0h0dVMvR2xHbDliMC9CdEoz?=
 =?utf-8?B?Yk1abnFGWDJ4OTFZcHdjUUZDcHVIUzFqOG9IMmtLWWRWN05qaW5iRmM2Yzls?=
 =?utf-8?B?L2ttaVd0RTZvM2huU3Rybm1QbXpmYjQ0SVJrQjFLc0V6OHBXczM3NGMwcWw4?=
 =?utf-8?B?Mmpsdi9PU0pNY2srRkQ0a2FJNnhzVExPRStvRDlZV3RzK2RwNWlnNGVubmZV?=
 =?utf-8?B?UlFxWlo0NTdnSjZuNExSZlVQYnRVWEVhbFpHVEZCN3UwWVZCTDBlamZDVU5i?=
 =?utf-8?B?N1BycjJVR1RMZnJKd3prTVcxdFNVMnpBQ1JlYjRBTTlYTFk0cWFBaVdUYk9t?=
 =?utf-8?B?YlFacENkOE00ajdMOUl1V0xjWVduRkpvOFY3b0ZVZHIvSFVUenNwUXZXOXcr?=
 =?utf-8?B?L0FFK0ZPQXY2c2c2YVVsYU0zem5sSThyRmZjODU3dE1MMGlIeGIzblNjWUFR?=
 =?utf-8?B?czNhWHd3QnJ0S2xXcDFaZkQ0cDFiY2JyZGFId2hHV2tVWFU4M0ZpM0xSUVd5?=
 =?utf-8?B?YkVTV3JWY1ZTM2tHTThOY3Y5Q0NoUUFqc0tYOExnWkIzanBvTmM1cmp0cUxy?=
 =?utf-8?B?d1RQUWQ3TTYydThWdExVdnBsL2wvMnJMMGFVNEc0d0xrVUFMdnVWWUZ6TnVa?=
 =?utf-8?B?WkRSSEZVU2E4NDlQZGhKMWtHNkZVd1BlT01jZDIzWHlXMmRVRTBtSTJZQTZh?=
 =?utf-8?Q?+xmHYx35nN5T3G08nwdXHRGLR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d87a99-ff67-4aec-7eec-08db8c81241e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 20:04:08.9278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+PjQuAMCZF0vhEaNEtxA1H9hcTAxMbUilu7GwnDH2+GsL/fXIQnTjVQ/niaj63b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
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
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Michel,</p>
    <p>Please check if this patch &quot;drm/amdkfd: start_cpsch don't map
      queues&quot; can fix the driver loading ring test failed issue on your
      system, I am still not able to repro the issue.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <div class="moz-cite-prefix">On 2023-07-21 09:30, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:0a99c609-c5c2-25fc-4ceb-52a0b4a49f29@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2023-07-21 04:55, Michel Dänzer
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net">
        <pre class="moz-quote-pre" wrap="">On 7/20/23 22:48, Philip Yang wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 2023-07-20 06:46, Michel Dänzer wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 7/17/23 15:09, Michel Dänzer wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On 5/10/23 23:23, Alex Deucher wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">From: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>

Rename smv_migrate_init to a better name kgd2kfd_init_zone_device
because it setup zone devive pgmap for page migration and keep it in
kfd_migrate.c to access static functions svm_migrate_pgmap_ops. Call it
only once in amdgpu_device_ip_init after adev ip blocks are initialized,
but before amdgpu_amdkfd_device_init initialize kfd nodes which enable
SVM support based on pgmap.

svm_range_set_max_pages is called by kgd2kfd_device_init everytime after
switching compute partition mode.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">I bisected a regression to this commit, which broke HW acceleration on this ThinkPad E595 with Picasso APU.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Actually, it doesn't seem to break HW acceleration completely. GDM eventually comes up with HW acceleration, it takes a long time (~30s or so) to start up though.

Later, the same messages as described in <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/2659" moz-do-not-send="true">https://gitlab.freedesktop.org/drm/amd/-/issues/2659</a> appear.

Reverting this commit fixes all of the above symptoms.


I reproduced all of the above symptoms with amd-staging-drm-next commit 75515acf4b60 (&quot;i2c: nvidia-gpu: Add ACPI property to align with device-tree&quot;) as well.


For full disclosure, I use these kernel command line arguments:

 fbcon=font:10x18 drm_kms_helper.drm_fbdev_overalloc=112 amdgpu.noretry=1 amdgpu.mcbp=1
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Thanks for the issue report and full disclosure, but I am not able to reproduce this issue, with both drm-next branch and amd-staging-drm-next branch tip on gitlab. The test system has same device id, running Ubuntu 22.04, latest linux-firmware-20230625.tar.gz, and same BIOS version.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">FWIW, your system has PCI revision ID 0xC2, while mine has 0xC1.

Also, I'm currently using linux-firmware 20230515. AFAICT there are no relevant changes in 20230625, but I'm attaching the contents of /sys/kernel/debug/dri/0/amdgpu_firmware_info just in case.


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">I attached full dmesg log, could you help check if there is other difference, maybe kernel config, gcc version... it is hard to guess what could cause the basic driver gfx ring IB test timeout.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I suspect the IOMMU page faults logged in my dmesg might be relevant:

 amdgpu: Topology: Add APU node [0x15d8:0x1002]
 amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x122201800 flags=0x0070]
 amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x1125fe380 flags=0x0070]
 kfd kfd: amdgpu: added device 1002:15d8

There are no such page faults with the commit reverted.

Other than that and the IB test failure messages, our dmesg outputs are mostly identical indeed.</pre>
      </blockquote>
      <p>Yes, I don't have IO_PAGE_FAULT message on my system, thanks
        for the finding, I will continue investigating the root cause. <br>
      </p>
      <p>You are right, the error message could cause gfx ring IB test
        timeout failure, this patch does change the order of driver
        memory allocation. IOMMU is in translation mode on Ubuntu
        config.</p>
      <p>To help confirm if this is caused by IOMMU, please add this to
        kernel boot option to set IOMMU to passthrough mode, check if
        this can workaround the issue</p>
      <p>iommu=pt</p>
      <p>Regards,</p>
      <p>Philip<br>
      </p>
      <blockquote type="cite" cite="mid:d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net"> </blockquote>
    </blockquote>
  </body>
</html>
