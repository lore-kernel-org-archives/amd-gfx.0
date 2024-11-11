Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A04D2E9E4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 12:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCA910E48C;
	Mon, 11 Nov 2024 12:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SjR68bZT";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C72010E48C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 12:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAI9vzg+LTYkcSOqMpjfEOuoIX6vyeHS4v0pMQfEVP292zEaxXmBeJsKDFicbbKiWCjPO1i4yOYKAXmREXKo3GYTFzbghqnOSrgcIkU0cq0j/p0XjXvHKotbLtNj1GO/ES9Q5BIdXGspkvnVIWWSchBMSPMeRSgKb+Uh9Z28kS5itXgzV5ly6A4TUJlSXG7VUdZjy74kIWPaT5nxFjMrgoSJc8EkR+kSNggzqXbIEWgw3V7U+IxRIDzTOOMoWuig5WHb+NJ5CqRk9Juz/QW4c2f5onOL4arNjrtEj9HTeAa31s4XTOvGtxW4vvubMmN04PL/YL6F7fdW137pisY+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mheBIF/1u0wzfIHj2zRMMSnocu+wUqAODjfYIQtB8Q=;
 b=wP0zOlZ+iqU0O/QfMo5gcpIcHDs8KKHpihc1BJeIwmyQlOij9dWi7zl2v0HTlcJWRPP1CiCv8zauwTjJrfycB62zd9ji7R1sqsAWfwTVAKswJ0qB7GMff9W6tHdmE1IpK7H9ECCr8cnKOfy8paXynpEmCyeB+WSRmd4xUJYjRBrEdGFQir4izZ3N15VKZ6hFqKwEQwXqAmW4v7wtMBxXlXJtC0lvnGCCgAQDASpXA8TaLyExToH3jLEGoCjJ5qG2vUCLw/kLE9sbEkv2ksPQdpr18f+a2WJlvpf2SUTR42VfQm8v8Zx3MDFQC8Zaba/CUCgU5MS4TfVUM1TM+pynAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mheBIF/1u0wzfIHj2zRMMSnocu+wUqAODjfYIQtB8Q=;
 b=SjR68bZTQST0ABWwSa9i0MGlLrryi+sYkGmgOED6LFN6vUTkkPEr8eectSpoyQlcF7dMjcj9p4YWD7xvewmXeE7tncmi6m83GkI2GTt/IwGF2mgEeW3eeIMwMuKlMrTOPMjlxVDU1gjBOP3JUtm2Vk20Xb/yWxvmtzEmqs0bDqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Mon, 11 Nov 2024 12:29:19 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 12:29:19 +0000
Content-Type: multipart/alternative;
 boundary="------------ewLnxCSq6S0cFejvKZZKJZBI"
Message-ID: <1be39bce-861e-4291-95d1-96c23ddfd570@amd.com>
Date: Mon, 11 Nov 2024 07:29:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: Add 'inst' parameter to kdoc in VCN
 v5.0.0 functions
To: amd-gfx@lists.freedesktop.org
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: YT4PR01CA0386.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::7) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 25deffe0-34c5-4826-0974-08dd024c76bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlRLU0tyeUwzNWYxYXdkS2FOQW1LSDJOc2xOb2tmUUNiSWFXVFNqemVkZ2ly?=
 =?utf-8?B?cTRPeVVLV0Jxdys3UCthYXpodFhEUkxyQnloUUtJclBsWjJyV2N3dTV1Y1lM?=
 =?utf-8?B?c2lxa3RFdHZPcndoaGZsaGZqN2todXM4K0dhc3ZqLyt3OUVlK3RtMmdNNlha?=
 =?utf-8?B?dUdjLzF4Y2taRnNhVHRMWWtnQ2dRdEVWSDVVdThRcndDL21jYkg1ejRwYStv?=
 =?utf-8?B?TmI0MWhaZHVzenlMd0dsYVpvYUgzOWFxVUZ2bWtpRDBuNzZieDNCZFdZbGow?=
 =?utf-8?B?azBkRkNQRWZ6QUk1VmxWQTdJMkZlMlh6T3NzN25GSURsYWRDRGpxS2NDSmxD?=
 =?utf-8?B?d3dsVm1ndDdrUHdoMzV2dEQxNFd2QldTb0tuUnZ5dlcrOFV1eWgrZkMrZlBk?=
 =?utf-8?B?VFFiNFYrZ1pWQ1FOR01jek1OZFdiNnpMQ2dlTlF5WExuRUtiZ0NkZm56djM1?=
 =?utf-8?B?NW5KZ2ZwOWhJei9lM0wvVTJvanZTNDZwNGQ4RkFNVm40RXlpc1BzREdwcDQ1?=
 =?utf-8?B?dXRWZm5ZYjRteUhjOVEwUmdCdGJDWVFkSnhDbjV4eHRDbGZiQlc3Qis2blhK?=
 =?utf-8?B?cm1VRFFXNG11WmpNSVVvWHVWNWZLaWRWbkNyQ3hFaU9ZeWEvRGN0OEwvZTYz?=
 =?utf-8?B?aWE0Rll6NEZaZ0djQ3ptb1FhcVFVZC9SSGF0R1AzZTNQU3ZXajBGQ1hEbTIw?=
 =?utf-8?B?OWtnT0RxdEs3b1M4bkRqaHNsd0dNanRQZUpscCtieWtGSmJnTlFZc2ovN29W?=
 =?utf-8?B?Wi9QZXVsQTYza1VES09UTG1iMEJMSEtwVWlKS0M1WTIzbTM5MitxZmljODIv?=
 =?utf-8?B?c0lkNWxpeGZHVmEvSE1FZ09XZHlhRS9wRDJSaE50eVpaOUN3NGdQWm9PeTB6?=
 =?utf-8?B?K0ZTL2w1M25aZEE0WkgyKzhGU0U2ek43QzBHMi9ybXhVbmt6eGNjMDhva2xO?=
 =?utf-8?B?U1VyOW4zOFpGcFBOR21zMktBdmtVRlJYZnZSditiUUo1bHRJNmtySHI4blBq?=
 =?utf-8?B?Z0FjMUE5K0hoSmQ3Y2o1MUNDM0VBTWU4TjF6eFlueEhsUUcvN0JHNVV4NHBB?=
 =?utf-8?B?akRpN0dacnNWVUxzZkpRTFZLUTZwT1MyZytQV1RnVkVGdkRkanhyZ1lsSHpZ?=
 =?utf-8?B?Ri81SFdubWlQVFpsTnpzYnpIZjIwdjY1eW1DRThJMCt6WDJseFdpL2RMUVpB?=
 =?utf-8?B?V2Jqc3l6TjBiNkZiRU52RjYxUlh4SERUUEJSamJIckZlMW1xWDVLdTNrMlN3?=
 =?utf-8?B?UG91SHV5czVDT2U5dm81UVI0eG1kOTlTTHhLNkhaZ0xoalBTRjhudC8xZWdV?=
 =?utf-8?B?b0ZqY1M5Vk1lbWxJSHNtejR0dmxnYWIvdGJFZGM5RGZDb3FVVndydndKTkNF?=
 =?utf-8?B?WTkxenIrcm55OHJpZEFqeCtqUnVTZUpMQ1REdDRlOWNrZzN4QzhzMmNOZGRO?=
 =?utf-8?B?QWFXT0pyckplUVpkTFNvaGQyZUxqaHA4dk4wYWJNNW1QQUlXVkkxZnIwZW9h?=
 =?utf-8?B?VUh3S3BxbnVseVMvVUUzbGgxQnJ6MFljdHRGU1M5ZXBzTVlUVDdGbHQ0cGhw?=
 =?utf-8?B?U1FTdXhQUWNYRnBYU2wzemxrbWxneEFZajZQVHI4V3pLSzlPaXhoMGM1aVg0?=
 =?utf-8?B?T2ZJMzVjMVlTNE5icFJRY3pxS2x0dk9iWk9iNy8vZE9oRld5b0E2NUwwYWRs?=
 =?utf-8?B?dlRTZFhmS1RmVFh2Y1JxQ1U0bUNrWkpKM1F5UmlVOFE0Y1dldEFVN2RyQlVz?=
 =?utf-8?Q?l3U1GpyLsCnCCkEYAp9OxTcjVWBRdf4HgQ177Sa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmhFYVVuaWJ1Y29iSTRXQlNyMWRvOG9oaWxKaVd4QjJOWmhXN08xSEtXQjM1?=
 =?utf-8?B?MzYvT0x5SjVXa1VyYzlVaStnVC8wQ0ZreGZ5eHRjMkRPYnEwTkFpTzVabGEw?=
 =?utf-8?B?UVorWHJKRmNsTUpLd0F1RzBqZUQ3MzRmbm5OUjcvamZrL0JpZjhxZnJIRGlF?=
 =?utf-8?B?d2tBeDhzMnB2VElLdlIwdFlRNDVnVmNOUFhpREhKcm8yTFdpMnRoQ3BoNzVO?=
 =?utf-8?B?NnpSUnpIa2x2VmtwSTFuc0lzaEVLN3kxdlRZR0lLWWpMUU5TUXc3eGJpZmp4?=
 =?utf-8?B?MFJqamVTb2pIb3ZyYjZCbThrVERPZVRzd0RyNldIbngrbWEzNWw5RCtGODlI?=
 =?utf-8?B?ZjJGQVowL0FJSzdSMmNRVEw1eHVFNlp4QnNtcEFuM29hZ3VWanFxRkF0SnhR?=
 =?utf-8?B?S3drUGFuWTBzNVNsZ2llYnViR25CNXIyS1NaVWF1cW5kWUJLbHdmYVpUTGF2?=
 =?utf-8?B?MjBzZlhrOGkyck42VXZTQ3Vpd3JTc1VmRHA2QkcrdkhqQkdSRHUyWHBJMzIr?=
 =?utf-8?B?b2p1TXcwbGVRY2xOUGI5WnpkUzByeHlpd1Awbzd5R3JYQmhtb0todzRMMG1K?=
 =?utf-8?B?b1F4ZURPazYyRXAzVi9MYlpBeGtvNDFjWEZ3OWIzUHNGcGEvVlNxYXB4NDJj?=
 =?utf-8?B?L0xRaG9vS2h1R05QelhUZHV1aTZ5Rk5WemxsY2RGYThtSWhGVmtwNEJPQW4v?=
 =?utf-8?B?WWdsczZ2dlBuQWFSM3pWamNMK2ZNR2xQN3BHVGNzOW5lL2xwblV0c2VGdXdQ?=
 =?utf-8?B?RkpNalBkVkdrNWI1dVVlWXA1RERoTU5iNm9IQ3BMUmU2cjFFdTBJYWVQejly?=
 =?utf-8?B?OVNsaHhGbWhQNlM5Nm1NY05PU0NCMWpoNFBHV1kvNFh5TmhCMWZ6M3BWVGV3?=
 =?utf-8?B?Y3oraFNvekR3aXQ3MFFVTFc1T3gxVHQwNmNmdjdLS0FOUEpzSjhQUUtEV2Jv?=
 =?utf-8?B?TnRRbHBtcWNPT3pNeENCa2VzOFBkWVI1MVZwcmhzcjdnU3NJUkcrMERmV0I4?=
 =?utf-8?B?OEFlL3Rtb3dNNzZMeGYzVEwycjBJbDR1T0dMQ3YzQUcxNUpITzNQNlI1dy9B?=
 =?utf-8?B?a0dzclVjQ21XWk0zeUk5SkhuOUlna3VTWVB5bFUrYkljZkRkSHRTMW4zSTQ5?=
 =?utf-8?B?K3M3NzRZMWRSTEh4UFMwT1VEYXFrckxzcHNmVUJwWiszTnBMQkxFN21VWEpF?=
 =?utf-8?B?NG1VR3NwdWhRY1JvUDFaQlZnRllKTlY3TlNwQ0JWUTh2M3ZrdE9lMzVOdVhL?=
 =?utf-8?B?OFo1ZWF6NkZGeGRDM0xQUzFBbS9qdVJIVHluTjhlTzhBM1FmekYwVC9zdVJE?=
 =?utf-8?B?SGV4NTlyMUJudnorU3pGU3M3V3UvM2hoSFRvcjBOSFBYWGhvRVBxN0JKN2N4?=
 =?utf-8?B?SXExZVRHSnVMbG5EcjFmNjV2bGJRd000WE9FcndEY0Y3SDFNeXlkUVAwZjl0?=
 =?utf-8?B?Y3lMMCtNaXEvZUdDMlBnQ0RwMHJaYVI3cWkvd3dOQUptQ2lLcVpWTGUxcmg1?=
 =?utf-8?B?eHRLQ3VTNEJCRTNBcURPd21SbVVOYk5zUTBSZk5nTmIvVldnbHlaekdpWHJo?=
 =?utf-8?B?aHAxbjhMaFRhZkF2cUpYQVdRZnNGQlRCZVZPY0k5bzFpSWg3MWk1M2ViZWEz?=
 =?utf-8?B?ZE9CNXZLSjgrOGw1WGVpWExNL2EvVW1FNk5udllmS3h0ODZVc3JHVzQ3MGgw?=
 =?utf-8?B?dURjbFpuNmhYZFlhOGprUXhvSE14NEZJSmhVdjV0c3o4YURQWDlhNXUyanVk?=
 =?utf-8?B?UTVTSDBlc1dXam56bFJpTzVPek5BbXpRNFl2MElzY1lWNkc4c0ZQSTlodWpH?=
 =?utf-8?B?L0oxQVhFdkFXc1kvN0hWekgycHJMbVhTZXRGRGJsSjJpUmFEK3BqTnRHZ1dm?=
 =?utf-8?B?ck85QVRzR28zS3Z4MmxHckZKRTRVRk9mdG16cDA4eTZ1WG1YME8ySDQxY2hI?=
 =?utf-8?B?Y3lFNFEzVmpudGllZlpKWmUwNFVQakMyemZDTWNiSmhMdkVWRTRGaXZQL052?=
 =?utf-8?B?NTNIR2xhdlJMMmhQM3U1Y3liV0JYWWNGN3ZHYldUd1FoMU5KNFlKY0cwWFAy?=
 =?utf-8?B?ZWhTdnpmSEJGR1Q5cU9uK0VIazNFclNSb3hsRE91ODFSWlRpTlJVcGxka1Ax?=
 =?utf-8?Q?l+zTeNCG0hXUXsZe0xaK58uc6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25deffe0-34c5-4826-0974-08dd024c76bf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 12:29:19.1550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jazS+xpR2fpUwd8fd01A/QQz4WZ8f/PoLcoYFQIp21QWoE/TQT9FDanvUEo9ZffOZGm3x2lV48uDjfvMBCU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

--------------ewLnxCSq6S0cFejvKZZKJZBI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-11-10 21:46, Srinivasan Shanmugam wrote:
> This patch adds the missing parameter descriptors to the functions
> vcn_v5_0_0_start, vcn_v5_0_0_stop, vcn_v5_0_0_set_unified_ring_funcs,
> and vcn_v5_0_0_set_irq_funcs.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:767: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_start'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:949: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_stop'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1165: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_set_unified_ring_funcs'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1331: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_set_irq_funcs'
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index a72de204f130..66447e8459ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -760,6 +760,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>    * vcn_v5_0_0_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block to start
>    *
>    * Start VCN block
>    */
> @@ -942,6 +943,7 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v5_0_0_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block to stop
>    *
>    * Stop VCN block
>    */
> @@ -1158,6 +1160,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
>    * vcn_v5_0_0_set_unified_ring_funcs - set unified ring functions
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block for which to set the ring functions
>    *
>    * Set unified ring functions
>    */
> @@ -1324,6 +1327,7 @@ static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
>    * vcn_v5_0_0_set_irq_funcs - set VCN block interrupt irq functions
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block for which to set the IRQ functions
>    *
>    * Set VCN block interrupt irq functions
>    */
--------------ewLnxCSq6S0cFejvKZZKJZBI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-11-10 21:46, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241111024612.1881727-1-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch adds the missing parameter descriptors to the functions
vcn_v5_0_0_start, vcn_v5_0_0_stop, vcn_v5_0_0_set_unified_ring_funcs,
and vcn_v5_0_0_set_irq_funcs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:767: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_start'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:949: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_stop'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1165: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_set_unified_ring_funcs'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1331: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_set_irq_funcs'

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <div tabindex="0" aria-label="Message body" class="XbIp4 jmmB7 GNqVo allowTextSelection OuGoX" id="UniqueMessageBody_29">
      <div>
        <div>
          <div>
            <p><font size="3" face="Times New Roman"><span style="font-size:12pt;"><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody">Reviewed-by</span>:
                      Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="0" id="LPlnk671546">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></span></font></p>
          </div>
        </div>
      </div>
    </div>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20241111024612.1881727-1-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a72de204f130..66447e8459ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -760,6 +760,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  * vcn_v5_0_0_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block to start
  *
  * Start VCN block
  */
@@ -942,6 +943,7 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v5_0_0_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block to stop
  *
  * Stop VCN block
  */
@@ -1158,6 +1160,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
  * vcn_v5_0_0_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the ring functions
  *
  * Set unified ring functions
  */
@@ -1324,6 +1327,7 @@ static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
  * vcn_v5_0_0_set_irq_funcs - set VCN block interrupt irq functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the IRQ functions
  *
  * Set VCN block interrupt irq functions
  */
</pre>
    </blockquote>
  </body>
</html>

--------------ewLnxCSq6S0cFejvKZZKJZBI--
