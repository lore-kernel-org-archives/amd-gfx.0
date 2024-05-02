Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594CCC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 14:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C9310FAED;
	Thu,  2 May 2024 14:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Md+PWgql";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F8710FA0E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 14:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgHUFoWQgaiCNaELdMpodEQH2pR0kROkeV2e8vy4DrOHymn0pZ4urNUrLVLOr/3kCuCn0HMkdYXg9QdxljHyHpd4lz9dEJD4ccqvf8nkd8jLyiW/yYh8iAXHmYxV3OWdcDjmmYCleBjpL8oArASbHqdG/NIyRTnX+Ftj7Hq990YKHF3+kVbn2BzFsCnxrJbGKGnhOg/gIhHjflry/0nAF+UzFmn/3+paT9WMEulzA3A6IVy7ELkqJES7qllJayVKMW62LmNM4+vgO8pnbJLFdC9CRkeJiuRzHY2bOUEpyCrL5zWsGFssordm7gu3TFpfuygtAv7R5qysmUyGMHGcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUM3m4ETtxlb4qHERVfCzjiwKuLUHvCzn57PXo6bD74=;
 b=iqhDYoZLMFZpkAcWbq6yBFdp5hXJsrdDvpuFT63SPGuiLwr0vAvlBWggQweoi2TCLyM3SOro5D2A/VgZowB1PFwT3Wn3yzfVe+Jo6cv5hVmwTJvPgGbyOaJNVZo+892odHoKhX+ZgTt3snQb+AHb5i83S3iUvZXqe/zqQB0aDKNKHSTkJzJusOXhQkDbCrpgWrQvFfLVnqYiNHKzimnKjEqopwqws8CV6tbGLED1lqZdw8WeT6Ba7B43VVoyuvFJbK+WlnxF6vBqNvzK5m7ciS86K7x6T3e6aZ2KNieu33Xoe5bVkb18dNQGLy8I6nuKOXEus5WLunMYiQYWMb/MJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUM3m4ETtxlb4qHERVfCzjiwKuLUHvCzn57PXo6bD74=;
 b=Md+PWgqlUPBwumfbzS8VHent/LGVYbWsqO5Yti+iR17jL91aRTCrj7PKgtDolsyz4SrPlslRCGoev+KLJGOsw1MC8JXdwgoV1IHYqMEZ98Bgd65WRtGFXIIEwBN/aYOHMZZ06EHh6uV3IvkbSht1hqcMXwIEXPkZhKIKTkIo44U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 14:06:16 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 14:06:16 +0000
Message-ID: <073a794e-2324-730a-d3c3-bc434dc07ef6@amd.com>
Date: Thu, 2 May 2024 10:06:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Remove arbitrary timeout for hmm_range_fault
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20240501225655.5215-1-Philip.Yang@amd.com>
 <d949949b-fb30-45c7-a53d-a4d32874b3c7@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <d949949b-fb30-45c7-a53d-a4d32874b3c7@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ea013d-d479-459e-58bd-08dc6ab1086d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUdQK1RMZEFRbDl0dk16dUd4c0NEbmw4di92N3YxWjZCcS9CTzFsOFUxQmdC?=
 =?utf-8?B?aUNDcEp2eUlPTVdkMnZKWjMrNmRIWnp2bFZ4K2kvUkMyNmUrNktQZFpDU0VI?=
 =?utf-8?B?QzRTSFMzalFBMkY0dkE1MHI3ckZkQ3ZLcTQ5WGJ3MnpRVmJWNTMyeGFPa2Uy?=
 =?utf-8?B?YjlvOWJUQ1VUWjF6REoraGttd1Z5VlIwcmZpV3BkWE5tOUF1MXFNSDFmWGhG?=
 =?utf-8?B?RTlOWGJ4Y0lCd3ROZ1J2UkhOVk1ncC9NQjBnRnZoZ0xKKzcrNHh1NlQwZkh4?=
 =?utf-8?B?dVBLUEtRbDlQc3VJbEs1V2d1bnAySGZZQmd1RUV5M0dmL25hVS9TVGN4U09j?=
 =?utf-8?B?WUIwMFBVYnBNV056S1RwRGVmRitSWnZmdGFHYkQvV1NCNHUyUkJ0RHBOZmZl?=
 =?utf-8?B?QmFrQko3NWdKd3NmZ2hxYWFyeW96WU9vUmIzQ1lCUFJoQ1FTZldQbVAwZjc3?=
 =?utf-8?B?TzdDYkV4cnMxbjBVazh4b0FyV3BEeGhuVStNSmUzaW1oWXpRYnF0MjJDR3ZG?=
 =?utf-8?B?dWdwOGIvNTZNMktUVEsyckFOa2hMYW80N25WOFRic3BqN2tPRnVDZFdJQkJZ?=
 =?utf-8?B?c2VCZ0ZUWE1RTVc1aU1WRXNPQkZJWkttQmw1LzdKdlFMZHYvSGRhUklPNmlx?=
 =?utf-8?B?SlM4VGIzSzdQS1hnaUExTHhqY3k3dmthbDgya0FVQUJNS3FRMXhnZkd3bWh2?=
 =?utf-8?B?NXRuckdtend4c2d5SkF0UUxQUHEvdFllTWUxTjNKNC8xN3FMVDF1QU8zUVVx?=
 =?utf-8?B?UHJDNXhkbEJuc0lSRzRiRkZIYTVqcUVydTZCNDBkdEx6VlJjdm13cVNZamM4?=
 =?utf-8?B?ZmY0VXJzT3lRVkJLc3k5Ujg1OE96ckgvdG5pZUNONEpvZDJHT0ltOVFiYlVK?=
 =?utf-8?B?L0ZQRkk3YUlVSU12SU83VlBEVDVEOXg1eTQ3bFM1SVRKUXAyREQ3dWhUWmVo?=
 =?utf-8?B?bW0vN1hoczhrVVNzM3FpNDZRY2xCSXJrQURqMHVKS0ZHTWp1VkRqbEZzbU0r?=
 =?utf-8?B?NVR4SlhmSXYyc3pQRC9COUp2RlhyT0JpSk1nbGVncU9nd1Fta2RVU0R0THlL?=
 =?utf-8?B?VUZsWlFDRVBoK1NBOHpMMjlzVER6VU9yamFzTmlWeXAyK1ZZR0IzNXVvMG5U?=
 =?utf-8?B?aktWUk5LQmFWUyt1cDdrNVl1M2xuNTVUWXY0NUM0U3MzbjRZdmJ2SlM4OTNZ?=
 =?utf-8?B?cHRpVC9KK05jZlR6aUVnbnZvRFM4NzFycWk1by9HSm55dWRlc0lVa0tOdERE?=
 =?utf-8?B?bm1BVGlhcWppemZUZjBoWmttM09Ubkx2eEpwYjBlUnRPQzllRVBsWDAyWXUw?=
 =?utf-8?B?dHExSzNMY0V0Um1NMExhRDZSMnd3WFNYaTIvTTk0VzgrUCt1Y1ZkcUFnRGtC?=
 =?utf-8?B?bGZBTThqRk5aNEllQmMzQUZBb0hkcVkzZTFpN3RHTnhsOEplMDVkcFkvSWpu?=
 =?utf-8?B?clJPQmVnTEVjRlpWYlRtMDR2VGMxMWNTSjFxT3hIOFB3MndxamRNaFRydFBL?=
 =?utf-8?B?YkxWaGtxZEVsSk16SUdrVGloaFRPaWdhQStSQ3ZVOWhKN3B4WkRYT2crRTdJ?=
 =?utf-8?B?b052aGlSK2tCUzNOZjNkM1JrK21keUo0THRaYmhWdnhNVExERnRBeGRVSlNY?=
 =?utf-8?B?bHpNZW42TWFzSjF6SThYckJDeCtBcDVXeUY5L2J0WG5WU2Jrbjd5SDZDSkFq?=
 =?utf-8?B?VEo1TnhEMjBBZzFOZ3JtNXZxZldiNDJiZ29QU0FoRmhSc0luYURyV0h3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29WRlp5YlZqQU54U0Y4Zmc4T2NuKzd5Ty8xVkIraWhuSDJScDEzRFlCQ1Y4?=
 =?utf-8?B?N3FSeEFuYWY0VXdjZUQ0S3Z5dk5mTFQwZDIzeUYrTmc4bFN3cUZwVDhiaWNK?=
 =?utf-8?B?bUwzT3NHVVU1aUc4elVDTVc2NHlqcDVOeTJzK1BZdnpMZHJxNlExNWtEVkhR?=
 =?utf-8?B?OTJaWDVRZEhqSzA5ZGFVNUdFajZwM0dlUmJYd0RJMDU4VElML2EyM1UzSTFq?=
 =?utf-8?B?eFBmSTNHaW9TNjRNOFVxSWxCQ1FFd2Z2dm5CUVpsK0E2R0NqUElUaEdTT0Ft?=
 =?utf-8?B?ZGxJM0Izenh0ZFJOa1AvODhhWE15TTg1MVlHTDI0Q0IyaFQydkVzY0VVcUNJ?=
 =?utf-8?B?K1VKUXZHN0czRE5Bd0NxZFg1cituMW9Hb1FmNVZCWWxHUjJiSE9yeDRVMGFF?=
 =?utf-8?B?Uk5hdWlLRW16eWpLUTUvYzNpd3lHUk1lemhod01LVU9teno0RWtQRUhwYkFM?=
 =?utf-8?B?R2twMEFGUEhOeWFkMS9kMHBWdEFnbmwwWHRuMnRlMWZiZDdzTXYza20zYmx3?=
 =?utf-8?B?N2gxbkJibkZudFNwTTNwR0tqbVdHVnRVdWFHMDAyb1NuMkJXazNSQWVlbGJ3?=
 =?utf-8?B?YVB0QWRRckRObWp3dkJkend5MDg5cFFEQVZRTC9qWlB5OEFGR3VDU0tPZEhn?=
 =?utf-8?B?aVVBa0U0NjJqbk9JWTdycnllbUJmWHRodGdnRUJNSExrTUQyMjVXOVIyeldM?=
 =?utf-8?B?Q3NMZ2NOOUJxaDNKWnJKdnNBQnIrVlo3L1pFdTFXT3NkVmF2YWlCZmZYbzJo?=
 =?utf-8?B?aTFSY1dIWTdlNWZSL3hlajRIckczQnFCdnFhUmxqbVd5eDJjZTA3RmFRNUZl?=
 =?utf-8?B?UlkwWXprdmg2KzVWY3BSSlc1dVN1YXpET2JlZ3BxR2hrWnB5OGlxS0VGazYw?=
 =?utf-8?B?NG9lajA5cnFBY3JwcWo0ZnhCMnh3UDRuSWUramJoT2p1cHArTDVOa3oyTDNX?=
 =?utf-8?B?eXVTNGtneU5hYWkrSER0L1pqQ0tteTMyMVQ3MTJtT0JXcHljZllQVFJuK2tP?=
 =?utf-8?B?bDZUY1FOMzFISHVOaHZIUHR1OE9CZTlRVHE3K3hyOWZhMkhyN0p4dFI4M3I5?=
 =?utf-8?B?ei91VkNBS2ZGVk1JY1hDVDhaVG5yYi8vQUhYSzlkK3BmK1E5MmxtNjBpc1Q5?=
 =?utf-8?B?eStsUnZUUlFXYndJTXNmbmJsTEpheHVaNUN1U2ZpQ3ZkZ1JEYUFIVG1WMDho?=
 =?utf-8?B?YkhaQTU3V0k1cHI3UlRtMHhFdzBJVFkzRFNTWFZmMU5tbGFkYi9jUzhnN3ZC?=
 =?utf-8?B?RE0wZXk1V2p2bjZQbGRNVDRiRVpTS3BXaG1uWWNoNEcwblJiYmp3ZDltTmJ2?=
 =?utf-8?B?cnl6dWlyb2dZc1RzeEFQZW5zVjhvVndmdGhrcU04eDlvRlhlWHIySndvQ1NK?=
 =?utf-8?B?LzgveHAzSGt3TjJMN2JPbG54NlhsY3hIQWdhOUNSL1dOUUZ1Z25IUUxsMVlI?=
 =?utf-8?B?UENZZThPeXNqWGNXOEZhemp4OXpmME5KUTZyd1gxRUs0REdieFVPU0pmeXlh?=
 =?utf-8?B?NFVRbEJLS0N5RzBJYnhVQ2RQQ015SVVHbFRmeHlzMmxGZHk3RU1OakJUQks5?=
 =?utf-8?B?Y0FtcU5Mc3hjdm9GenpBUkVUandERm1KZFZSeFRMWlRFTldVbStLM3dZUS9p?=
 =?utf-8?B?MjhwbmhQazJyVU5oRGtUeE83amZtQ2l3eTZMQzB4dkZnOHd5T2liUHhlcTZB?=
 =?utf-8?B?dmI5NTZCTGxkd0FDeVBaRFQvamRRVTdOWjgxclpxRmtoeWJrT0dkTHcwaVl6?=
 =?utf-8?B?QzROcTJkU1BCL2ZzQ1NWamdmaUd0cVpLTnY0V1NLaTAyeEQxN0tLQ1hPa3Fa?=
 =?utf-8?B?ZFhEdzJNeWZJWEV2NmNKOHVRZTRVdlo2NXF6aEdCdGVjbk1pWjEyK2N3VmJw?=
 =?utf-8?B?YjBGNFFOaXFURE5GYzJlSmRLMy9CTkZYTGRoREwrbHF2NXhWY3I2MWlXQzNW?=
 =?utf-8?B?OTNYb3dKTTNsY2RFekRuQ0YyZEZrcDhZTVZveER5S25zeDZGWEJNdWxVQ05i?=
 =?utf-8?B?bmYzWXlVQUZFaVFYTFFtUTh4Sk91Rkd4WE9ycE1wZFNSRG5waXRsakh4UlZW?=
 =?utf-8?B?eVBzeUthUTZOaFdkRndOT0V2dVlSb25iNGw5TW1pcm1QQ0NONDdlNVBSdHk4?=
 =?utf-8?Q?j8S4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ea013d-d479-459e-58bd-08dc6ab1086d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 14:06:16.4164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3x+fZsdpfJpr7cxEHp6Wej3JEfW0x7Dqf9n7tUHwz36FYORmLyUOlzDCMpdPW8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-05-02 00:09, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d949949b-fb30-45c7-a53d-a4d32874b3c7@amd.com">
      <br>
      On 5/1/2024 5:56 PM, Philip Yang wrote:
      <br>
      <blockquote type="cite">Caution: This message originated from an
        External Source. Use proper caution when opening attachments,
        clicking links, or responding.
        <br>
        <br>
        <br>
        On system with khugepaged enabled and user cases with THP
        buffer, the
        <br>
        hmm_range_fault may takes &gt; 15 seconds to return -EBUSY, the
        arbitrary
        <br>
        timeout value is not accurate, cause memory allocation failure.
        <br>
        <br>
        Remove the arbitrary timeout value, return EAGAIN to application
        if
        <br>
        hmm_range_fault return EBUSY, then userspace libdrm and Thunk
        will call
        <br>
        ioctl again.
        <br>
      </blockquote>
      <br>
      Wonder why letting user space do retry is better? Seems this issue
      is caused by hugepage merging, so how user space can avoid it?
      <br>
    </blockquote>
    The issue is caused by khugepaged + 4 processes + sdma stalls test
    (to slow down sdma) + small_BAR + QPX mode, during overnight test,
    hmm_range_fault 180MB buffer may takes &gt;15 seconds returns EBUSY,
    then alloc memory ioctl failed. Return EAGAIN, Thunk will call the
    alloc memory ioctl again, and we don't see the alloc memory
    failure.&nbsp; <br>
    <blockquote type="cite" cite="mid:d949949b-fb30-45c7-a53d-a4d32874b3c7@amd.com">
      <br>
      And applications may not use Thunk or libdrm, instead, use ioctl
      directly.
      <br>
    </blockquote>
    <p>If app calls ioctl directly, it should do the same thing, to call
      ioctl again if errno is EINTR or EAGAIN.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:d949949b-fb30-45c7-a53d-a4d32874b3c7@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">Change EAGAIN to debug message as this is
        not error.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |&nbsp; 5 ++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12
        +++---------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 +----
        <br>
        &nbsp; 3 files changed, 8 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index 54198c3928c7..02696c2102f1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1087,7 +1087,10 @@ static int init_user_pages(struct kgd_mem
        *mem, uint64_t user_addr,
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_ttm_tt_get_user_pages(bo,
        bo-&gt;tbo.ttm-&gt;pages, &amp;range);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s: Failed to get user pages: %d\n&quot;,
        __func__, ret);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret == -EAGAIN)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Failed to get user pages, try
        again\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s: Failed to get user pages:
        %d\n&quot;, __func__, ret);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unregister_out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
        <br>
        index 431ec72655ec..e36fede7f74c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
        <br>
        @@ -202,20 +202,12 @@ int amdgpu_hmm_range_get_pages(struct
        mmu_interval_notifier *notifier,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;hmm range: start = 0x%lx, end =
        0x%lx&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hmm_range-&gt;start,
        hmm_range-&gt;end);
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Assuming 64MB takes maximum 1 second to fault
        page address */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout = max((hmm_range-&gt;end -
        hmm_range-&gt;start) &gt;&gt; 26, 1UL);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout = jiffies + msecs_to_jiffies(timeout);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout = jiffies +
        msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
        <br>
        <br>
        &nbsp; retry:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hmm_range-&gt;notifier_seq =
        mmu_interval_read_begin(notifier);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = hmm_range_fault(hmm_range);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r)) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule();
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FIXME: This timeout should encompass
        the retry from
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mmu_interval_read_retry() as well.
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -EBUSY &amp;&amp;
        !time_after(jiffies, timeout))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto retry;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_pfns;
        <br>
        @@ -247,6 +239,8 @@ int amdgpu_hmm_range_get_pages(struct
        mmu_interval_notifier *notifier,
        <br>
        &nbsp; out_free_range:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hmm_range);
        <br>
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -EBUSY)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 94f83be2232d..e7040f809f33 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1670,11 +1670,8 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        readonly, owner, NULL,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;hmm_range);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task,
        NULL);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to get svm
        range pages\n&quot;, r);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -EBUSY)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        --
        <br>
        2.43.2
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
