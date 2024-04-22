Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7090C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 16:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4780B10F717;
	Mon, 22 Apr 2024 16:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZRg64G4p";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD0F112B02
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 16:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWdDSDYmjSAFyEBlnNtC3EmMqp3VfX3HjhZGv7qeCc/LRAxMMTQ8ooZDevtOymH+D5ojy7L5mVWFSHsrmNpxgn4DBegNUfzS32ND89VKG841BVkOy3kOInhy7ldOFsQyhzdrCfmUBi8q3ppzykOcgYOYk9Q5Rmeni63SC5a8u7YQPP7N9rWK/WfuQWZv58AkG1eGpU78GQr5Bmp7Ar4CLft39V4RxpYeMLKfodTn6/0mA9c0iB12ZekLenRUD9SI7DCpFNMT9e8+2WO07W7QLdnQYSd8WCXxOySUR5n4D3RsvEGqUEhasLtPykul9+URrMoIH6kIyOZfrqNwbpB6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOKR6gXBZ22UG8M7c+TQ4eiqUizDOWzwzXkhgiwYDmQ=;
 b=UXfR2gCXy+SPJrMgMTE7KbpAE7RsMw4xNGLhUeaNSsWz8Qv8uatvPcRDuzktPPRtdVYOW/2jkK6C+Bnj3LT/ot0WkOdZjY62ORIm1X1y/RBGSMo15Pbe91/9AaL/yWPxYsImtPNVJC2JoSl1Yj342wuDqZM9N5t3tlg8A0Ot2hhSZTiFpFHYFZ5FuvFRF6w+5J2s8MFDNPYv+Q0f6qLnfx+rzsO1XPJ5XIkvwZG48F6eZZ0zI0cU2iQ9G1bD0G+rppyJP79b19oxITwa598hdRPuHE/9Datk8OvZul8lAR3JYUaIJWKMxre0gTFobWb5oO+XMX8Sb7qeqkow9Ck62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOKR6gXBZ22UG8M7c+TQ4eiqUizDOWzwzXkhgiwYDmQ=;
 b=ZRg64G4pnfUrAmztWNvHOSDexjqtJcxQ96OoovpZnbBOHsPcbfYeyxyHeiUiurk6UMZeCiPvQoRgDrF0Ydq4rt5PoykfD78g8KcIKSC4B9aWH9YkYqQ/QFDV38SWrvEzoMS1UjQPEv5wdqM3gIQR2YYQztixrsdco37iWa8bHSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 16:23:04 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 16:23:04 +0000
Message-ID: <6ae01a87-2b17-d633-2cff-7415d3915045@amd.com>
Date: Mon, 22 Apr 2024 12:23:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 6/7] drm/amdgpu: Skip dma map resource for null RDMA
 device
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240422135725.11898-1-Philip.Yang@amd.com>
 <20240422135725.11898-7-Philip.Yang@amd.com>
 <c8e4a839-7f39-4cd9-a519-ce3c164464b5@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <c8e4a839-7f39-4cd9-a519-ce3c164464b5@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::36) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccc6ad3-b7c8-4901-363c-08dc62e87c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHk3ZCtCY2VuUHdLMkhnS1pqNCtzZ2NOanRDa1Erd3BqQzJWYzBiSkZ5TzdZ?=
 =?utf-8?B?REJCcU5yOEpTTVo3OGk2bUJiVWxuWFRiUjJpTkVGT1VORGxjd0FCMUE2bzNL?=
 =?utf-8?B?VERRN3RHTHVEOFYyaitaVmhYNjAvS3VOTXJGQzRYTEZsN2h2c3dNcVZ3UE0v?=
 =?utf-8?B?Q2RxQVJCc1U0MmM5NkhrbWllK1hDQVBSMi9XZFhUK3gwbEhrcVJCV1gxRmQ4?=
 =?utf-8?B?bEowYWRrQ0swa3lOdUY1SDNOSzNLcVQrUHlyUUhGbHJGZGh5N0ZxaEp5TTdM?=
 =?utf-8?B?ZXB1Z2xBMkJuYTFTYnFKOENUUG42VlRKUUxpdDdWR05DbHhQNUlXUmVYVUVG?=
 =?utf-8?B?NFl4cTE5SnlPWHZtdDJOQjQ4R0RtLzkvdTF1YWtoSGhJQ0FyWFZuc0dQMUs5?=
 =?utf-8?B?aHB3ZWRYdEdic1poM0l0UDhObUtOS0tTQnhIUm5sekJTa0RvV2VGRTNvSXo2?=
 =?utf-8?B?UUVOTlNNYkZYL2NGaDhtMmUwOEQ0V2l4OHVXcDJNMmY0QXpYL05jbnRKcDRH?=
 =?utf-8?B?VUlUUFBJQTR1MUhwWFYzcEdNVkE3RXlRUkRVeUtwQ0hnc1oyQjRxTkMvSU1E?=
 =?utf-8?B?Zm81MjVkd3Y2L3E3bHlOTzYrRlVTeXN2aFVvU2QzMXY5U0tvTzI1SHVYbXI1?=
 =?utf-8?B?ZVBSSStVQnU3TDdxT21VTmRqbnFlSUNNRjNZL0ZKczBuWk5BT2ZuZkljYmFu?=
 =?utf-8?B?RmhOTTJ3QWJjRXdsN2h3U2dtRzhEUnFMclArT2hJMzdMZkZIeTdwbml0cUg2?=
 =?utf-8?B?OGwzaGZSOVlLYW8rMG1iRzJQZy9rS2lTVXY0bUNFU3crVS9uUFdpbVoyVCts?=
 =?utf-8?B?Z3E1d2JuZUxFcFpqN1ZiMHRoNmxBNDh4K0VrRTlGeVlVUExpYXFnZURLRGgz?=
 =?utf-8?B?ZVJIdzl0ZS9YUlNNY3YrWGlyWUNKZGhTU1JhMXdTNkFPVytUckxzSmRWcFZk?=
 =?utf-8?B?VXN0VFc4UTM1NkQ3TlFlNnVzcWQvNXdxbStqckQ3Wlc1dzJNVFFyQzd2czlu?=
 =?utf-8?B?UVlDS3V1RnphOGdCUE9JVUJrNXV3dHdoTVlXcmNNSVFCYS83cUJWZ1ZycERD?=
 =?utf-8?B?VlpmNUp6TTNiS0NPcjl5aVA4TEJRQmQ4NGtQNk1aalJtR20yakVhVWpwMGdG?=
 =?utf-8?B?dTE2dUJJSTlGTUQrU3kyRkxVZ0VxeUs2NDlWbkU5aEtFZFRQVWdCbllvOUdy?=
 =?utf-8?B?b0VVLzc0T041REFZTkQ4d3FiSVJZVHMxcExSWmtmYzhWVHNQamlzZjN1eUxy?=
 =?utf-8?B?RFFZd3RPdmMwZ0lMYlU2Z3l2djJYWnhXM0trZjgwdDJjd2VaL1BYSVZuc0d2?=
 =?utf-8?B?MzZHWjdLV1kxeStuWGJ3VVQyb3AwNlB6cmJqMnhUTHc3em5XZmQyMDJ1U3k1?=
 =?utf-8?B?Mzg2dmM1T0hsNVZHeXlCMVFzYU9mWFJzMzdCemhwNW1CRXlaR3E3S2hzckQ3?=
 =?utf-8?B?K2wrWWhqRC9xRmNaYzlrSFlWQXRwbzBhb3B1OEVxYkJzcC8vcWJOWmF5NVZY?=
 =?utf-8?B?UDZHY28wWWxmRGE2d0hLUEYyTUF2UklHazdSdE5qMld3UXcwcWZaYk9zaEpR?=
 =?utf-8?B?cXlmclpJR1Z3RjhicDIvMzRsS3NVSWV5NFR4YW00OVFMY29tU3REWDdJditI?=
 =?utf-8?B?YzY2VVplZzhDOG9rTlNzVUNsNndoOEx4Y1hDV0YyWSs3NjE1Ti9rOGQ2RVZa?=
 =?utf-8?B?N1BuclgvSnZFa1ZMWUlEQVkwMEN6WlBvT1hycmpKNlFhZXkyTW1iWER3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3k0N1dmVVVCRnQzSkdoR3Z0TmwzeCszTFNXWWlNU2ZqYmxLb0lwYmE2NTVB?=
 =?utf-8?B?cVNaRFFTMCtWeVVvTXJ1NExJbHNrUHJKL3lZdUExejN3c3QycVN1TVVEZ0VS?=
 =?utf-8?B?ZVJ5Nnpad3JCOWdWemZDL1ZqbjJqNEN2ZENXM3Z0dkdQNzFrR3ZiV0FnUTJD?=
 =?utf-8?B?MTlhelVhajFxRkVvMExJT00zbjhWVDBxTHNudXQ5eGpDMXd2RnZVRVdodkxp?=
 =?utf-8?B?S3liRmJmT2h5YkJrRnR3QlFDN3JtSU5aUEhMN3NzNXlGQ3RURXRhSjc5RE8w?=
 =?utf-8?B?OXJ2RXhUOUpjTXNZUzFHS21idHZORG8rSG8yNTVQMWplalE5a1FyOWpyQUpT?=
 =?utf-8?B?aUNMdVl2MUM5UFpHYU5pemhLd3BFRUg2bDM3VVdxcFNkbXJSSjBFYmhVMmNP?=
 =?utf-8?B?QlNCL1Z6WUV3RUNhRU1aOU9sVUtFeCsyU014RDYxTzFmY045OE5ReE42bzJZ?=
 =?utf-8?B?OXcwUW5rVVBnWVdiOFVxVTc2WHQwWVVpbUxlOWFaUlVtRWFIVDNJd1dLcmY1?=
 =?utf-8?B?dnV1WW1Wd29pOURDRHp0Y054UDU2elNudmVsb0ZZYUtXTWxWWldyUkhZUnZR?=
 =?utf-8?B?RERKSWdXT2k3ZDdzdnhvUFpmZG8wazg4eFFGUVhpNUxHRm9BaTRRRk10dENm?=
 =?utf-8?B?dzB6c2sveGwyVlVOT3ViaHF3VkJOc1Q5RkpYampibG5UcnBobGRXdjcrRmlu?=
 =?utf-8?B?aWRIVUJudGl6RmJ5MkVQQjkwdTZScDFoSFpXTXNvNWFiUmpmQmY4WVduWWZz?=
 =?utf-8?B?VW9UWEhXcUlQbk5PS3hlMGNCRUJWQnJzbE5yMG9DbUs2UEhGTi9YSWhHUDdN?=
 =?utf-8?B?SHNIeW5RN2FsRTJNSWpjd3hrTVNnVHN6ZEl6RzhkMVo1WGw0UE9QRC9uRE9H?=
 =?utf-8?B?L09PZGhyQkVNVmNjenhKR0dpa0VxUFFWbWNBNG85YzdTeldWSk9sRXA3MDlK?=
 =?utf-8?B?dXlJcHltNTN5ZVBWdkt6ZmwxbVJYUFJqQXNNd0drZ1hzZE1qR3Z0N1l2ZU5w?=
 =?utf-8?B?cHNSWENqcnU3YkhzWW9CbEZvMmlnTDN4VXVjbTBpaDVDVEpEMGJMcGpZZDc4?=
 =?utf-8?B?NWpaMysreit4NGVnRHpaRlZTVVByS0MyckxBVC96YXUvNGtGZ08wOUhjYkV3?=
 =?utf-8?B?aFJxZXdITHFvOWNiam5rdENyVDM0WTFxMDFtZDBZam5GN2gvdFRyN2RaVzA2?=
 =?utf-8?B?YjI5VGlXUUVqSnlrdlJLUUNiL3dmNHpYdmxBanRlWURQaXpML0gxZHRBMjJR?=
 =?utf-8?B?STduMDhrWmNLMng0ejZqQlhSMUtHUXVURFA5NWF3cEF0VWJWNXVsYlJIS2VQ?=
 =?utf-8?B?cGtnTytHWFBlbllrbldIYlFuL0N5RUUySFZhajZQZXZCRklRMnJHOFFuQnk1?=
 =?utf-8?B?NkxsbmJTZ1d4YmtjTUw3YmhxbjB6MnhVNnJPOU5rd3NpeGJqRWJPNTRQTGMy?=
 =?utf-8?B?UGhsWU5od0Q0WCtNSzI1bFExcS9NTzVEeDVyQ2tJUHMvZENpUUxFeFVDMXlH?=
 =?utf-8?B?VStUWVZVV2lrejBuTTh0eURtV29USFhJUXNkNzRsUERkQmthWGY4VTVmbEV4?=
 =?utf-8?B?VmJPYXJrRjFJRHhDdTMrRVZOalhSNHRzNy9reGNVMDE3ZnJRczQxT1JKcGZl?=
 =?utf-8?B?ZWRMUVVnT3I1N1hNQTRRNzlDcVh0RVgvMHliR3hUZGt4aEhGUzN2UjVBcWM1?=
 =?utf-8?B?ZWRWWmRsR1R3YStaZHRpTTl2WktPWWFvVkJ3VFhRaFB1djFjZGt5TS9jZWgz?=
 =?utf-8?B?K0NpTW02emt5Y25vNllsSXhsN3I1bW9zRHMwZitwSlNUVzNqR3hDTDVpaFBi?=
 =?utf-8?B?WFV1OFIxQ2trd2hCQkdBbDJwenRkSytBQ1lqZDdtZTE5MlhtTm92TGdtdDZ3?=
 =?utf-8?B?NWZqeG5yQm1FRTErUkE4dGRaNSt6QU9KdUdFTStmbWZYQWYwTGlLSVpEWkh4?=
 =?utf-8?B?Q0pZOWNkWHJYREIyc1o0bTNkcXl2czZzTWY5U2s3eWlWZWxWZ05oTFdTN2xI?=
 =?utf-8?B?YVZRbERPY2VzZ2FKRkNtUVpvdE5YOWdNelgrZzJlTE1oaFYyUTdZSlVWK0Jj?=
 =?utf-8?B?UnVMa2dnM0ZMZ0htZklpZmpNZGVlYlp0T2Nsek5pRzg5ekR0UEZOeHZCOUkv?=
 =?utf-8?Q?L7xpnWTb5vRvdQf7DEEG1oyrG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccc6ad3-b7c8-4901-363c-08dc62e87c80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 16:23:04.2424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6txy8COiZiI4TJjLIrdwjyYjKVCR0b37/vA1oZj8zQthogQcQOj0yKAJyTLwwLt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
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
    <div class="moz-cite-prefix">On 2024-04-22 10:56, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c8e4a839-7f39-4cd9-a519-ce3c164464b5@amd.com">Am
      22.04.24 um 15:57 schrieb Philip Yang:
      <br>
      <blockquote type="cite">To test RDMA using dummy driver on the
        system without NIC/RDMA
        <br>
        device, the get/put dma pages pass in null device pointer, skip
        the
        <br>
        dma map/unmap resource and sg table to avoid null pointer
        access.
        <br>
      </blockquote>
      <br>
      Well that is completely illegal and would break IOMMU.
      <br>
      <br>
      Why does the RDMA driver does that in the first place?
      <br>
    </blockquote>
    <p>That is the amdp2ptest driver, part of KFDTest rdma test. The
      simple rdma test app and driver is used to test the driver path,
      without actually transferring data b/w machines.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:c8e4a839-7f39-4cd9-a519-ce3c164464b5@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 33
        +++++++++++---------
        <br>
        &nbsp; 1 file changed, 19 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        index 9fe56a21ef88..0caf2c89ef1d 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        @@ -705,12 +705,15 @@ int amdgpu_vram_mgr_alloc_sgt(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long size = min(cursor.size,
        MAX_SG_SEGMENT_SIZE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t addr;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = dma_map_resource(dev, phys, size, dir,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = dma_mapping_error(dev, addr);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unmap;
        <br>
        -
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = dma_map_resource(dev, phys, size, dir,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = dma_mapping_error(dev, addr);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unmap;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = phys;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_set_page(sg, NULL, size, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_dma_address(sg) = addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_dma_len(sg) = size;
        <br>
        @@ -724,10 +727,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_sgtable_sg((*sgt), sg, i) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!sg-&gt;length)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_resource(dev, sg-&gt;dma_address,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg-&gt;length, dir,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_resource(dev, sg-&gt;dma_address,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg-&gt;length, dir,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_free_table(*sgt);
        <br>
        &nbsp; @@ -752,10 +755,12 @@ void amdgpu_vram_mgr_free_sgt(struct
        device *dev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct scatterlist *sg;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; for_each_sgtable_sg(sgt, sg, i)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_resource(dev, sg-&gt;dma_address,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg-&gt;length, dir,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        +&nbsp;&nbsp;&nbsp; if (dev) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_sgtable_sg(sgt, sg, i)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_resource(dev, sg-&gt;dma_address,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg-&gt;length, dir,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_free_table(sgt);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sgt);
        <br>
        &nbsp; }
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
