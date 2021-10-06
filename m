Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112DCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 11:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB546113A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 11:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFB546113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584CB6E517;
	Wed,  6 Oct 2021 11:56:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275366E517
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 11:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW1zpZGWtLaLZ6mgSXG6CT7+ygm5jLyMqngplzqg015KirT76wjUwCPy8MNNqumG/fUREpqYPkyRnHtVxBlJnZKvh03kA5yq2ntJgUibIsZFOqRFND1LwQ/xZ6BqiCvOFSV+lSD455ZIh/ftq2NQozSwt4xJEZsACrVNzfdrbEK4L+eYsNm1J89wOHCx6K9dDMErI1zWo6vuz+ZsHKh34PSsJLO2jKHK6z34DP5bwemGia2RixeX1x7+pBDzue1PRQnIUONi2JJdaFBt6EOl/hBwiuvU6/9/4TI29gUCRx1Bz9nXVgEC8vzVjcbAGJt6murmZv7+YcquDxI7lN+8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxVlTrZ7AkyCzyTt7RP9dyWafS+QwueIf6qS36Qvh3Q=;
 b=A6ZLE6GL23yENdL2s0d0TIuCITL+XKbCLyCQzOlLrnjXmFOm5IFxsFXeFB/T4jCmvlJfJmvuJ1HPTAex/qtSys6TO7/dBhXnYWtYXMl8VAwgQM2u5bQfLalr8OoPoUuI/Ir7rJP2Z1vOuelMHLGlmsjKDbZSLD3ISXb5E3pAGK0DPCEiEmvEj2LD4A8VeOMr6vZpj5Zt0CqBMJSCdGd4xzYWoKfCLZSY08BuXpuvsM/ZI8Oh7dFmQ0xoHi0Ra15GEy+cKw3T0xpdxD/mPWgJpeV6aCkePdYLNzkVE85VIJwHdUfaHm1Er5aenmfoyVlrjbHrzocz75FhBJPxpenPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxVlTrZ7AkyCzyTt7RP9dyWafS+QwueIf6qS36Qvh3Q=;
 b=Ooxpi+6C3BL5l9epBk5Wo4nNVqtPz2czYRojocLzx5YFEEqgt+00XMi3p0DIXGWzDhA0fsTWVX86l8+p8JIdI7L7zElUUJiQ+piheLisg+XQpkaU4Y+J0ikuaO0genyBkdEE02oL//DnUk0VxKFeC1kixIFKIAfjqD2FFzolGgI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Wed, 6 Oct 2021 11:55:59 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4566.023; Wed, 6 Oct 2021
 11:55:59 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: return early if debugfs is not initialized
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, shashank.sharma@amd.com
References: <20211006095116.6221-1-nirmoy.das@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <b4fd745e-dbfd-70c2-5d80-6b00dc268601@amd.com>
Date: Wed, 6 Oct 2021 17:25:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211006095116.6221-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:bf::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 11:55:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cffd555-6fd5-4b37-4d5d-08d988c04327
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548C4359E609EF26B2A399797B09@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uW9TAVAePmICyv2ifn7GbWQXIar+4wGexnxKrjVUhtkkyJzXXrXg2GUxlPy23robLIQsNNW07PloFa1yJtdT06QNSt6PL7j1W1/+bmVgqXJKGkjVeLLkBgctId1BefSOWz1y2BVB5RUj7iV7xQcN2/kdgpT+X2QgamYJy33MilmaTjV9PWrkwE4A8qeE2osCbzKMYugwHN1cU4ECW/HhFieVwDOSuZBLQCqa7t7qYcAFIHVbHPnX+b9tkvIEr5esoap8llcrQWbQTpGRyo8apXjaHLK08+7Cs3/eV7WEWTp0bJ/c5f92Jg8FsAF5FEcAtuWPJhtkzVpISpXJv09/NN2/e3EK/1Lif7HgjeZJxplwahxbfxFllHeIGLGsdHtWx8koK4tEfkPsOOST808jSJl9mDExYj+EgysFcscWsWUNbBnfhe+7jc2VQ4IV3VqBV6cIl/ddyBXyx31Pn4WEMwNhSc83pB9bFBU7tBJ/d2+CNCWWxk+zMKLwLPI3gKOafR0Uwt2mARDmFifOFsPhtqMGje0ECAevZX7NIC8SAXSuaM228iBUwTaJQPWn9xjluLcmQny31YlgH8PDs6mTAcFfuQzE5dQ+1gGOl542DaZGu3CuiKHaTZ4byBzXD4Who2OrRQqpO5dejEnxkc8nkQkQVDDA12gd/vPnn+NqupTOcen3h6Td7ZH6JIhVQ4M+QKj6A3lVq4TEX0SRpfHuMVzUSXOnpJj+NV54Et3kByEBbOfhZO8rX95obhqn3oygYHJ7GN74ISuSliCzEKjfIF11Wt7+o1QFZly1665uNJrl0wYsTAkUVXYDG/NRbKV00Dwd6sK+OTA22vCA8e0sAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(6666004)(53546011)(66946007)(31686004)(66556008)(8676002)(8936002)(31696002)(16576012)(36756003)(316002)(38100700002)(6486002)(186003)(956004)(508600001)(4326008)(966005)(26005)(5660300002)(2906002)(2616005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEVQV25kc0FRSWJMZWk0RVZmVHVPNjhxMzV2aEZSeWdxL0E0bHBGWjJVOE9Q?=
 =?utf-8?B?Zm9BUGZsd0xQcDVZUWMwZ1ZRWjJnTWZTbEJwOGtQcStCdWorYWRWaVFzYTVi?=
 =?utf-8?B?OHcvd1crc0U3STV3eWMrL24yU3ZtUHg2L2taeXZuZTBZTytIalRvQ000ZkNz?=
 =?utf-8?B?aVhGd0MzUm9rRHI3TkVVR05ucE16Q2V1bjRZa0lzT3o3MFlmNERwZWs0SGhN?=
 =?utf-8?B?Y2VGWHJKY3FmSFpYWkxGMjFueG05SHBFNU5LbWN5Z005Uk9kVlBDSnhjem8z?=
 =?utf-8?B?RmcrZ0ZLekk5dlkvRmI2eTliL3pnS1U4V0QvZW9MbkRua1BjM3RycTRFWFpL?=
 =?utf-8?B?MTZUdnBxcmY4WndBSUFGd2tyQ1lRbUR3dkJ5alhMOGt0VG9LR1NKOFZmWlpZ?=
 =?utf-8?B?b09xNXg5bk1USVNraXN2OVB0dnNpUnBXcVg4WjJHOGlmbDgxRVRnSkx0VUFZ?=
 =?utf-8?B?cnlsTndGdkRtNVphdGFQR2UvUVdBdW01NGVrRFVVZC8xeHhDRmE5OUMxbXg1?=
 =?utf-8?B?Vmhpb1BNREFoaUJuakd2bUFlSVpubVQ4TkFNTXBhWE1qaG1wbkt4WHlMV2FU?=
 =?utf-8?B?dDZDQk5RWkZyaWRycXN4bEszbU1TQjlCb1N6Y3hXdzA2VVowNGlrKzd1SHFo?=
 =?utf-8?B?QnFsd1oyZU5zUmZIWlQ1dkU5OWI3UGhEZ25nRnF3T0FhQzFSVzJMVGlYamp3?=
 =?utf-8?B?MjFRT2I2bWNFTUdwYmFCVkw5NGJRMWs1S2FnMlFwaWc5NGg1aThIeHdkWEl0?=
 =?utf-8?B?ZXFUQTM2UHhCY2NKOFJyNlFXd3dIaHNyMmlHQWdpYlpia1kyUDMwRGs5RGZo?=
 =?utf-8?B?czZkSVU5Y3doUlI4NkhEVnVtV2ZWVGRLdWQxWE9EY3BucjVncjAwYUxyR2Z0?=
 =?utf-8?B?cVBuUmtnczZ3bWduUWs5S1NMZGg4TjRyK05nMVg0alJoY01zbEtURzU1amFO?=
 =?utf-8?B?bnlIRCtCeHl5Z2c4cHdsdWswN2FCY1cweDNVMGxSVFVtQ1Zja0U5bnFkc0NE?=
 =?utf-8?B?NmoySlcrZCtqVzhqR0p3UFAxTXFwT1hhakxROTBJRUJDL05LVWFFbFNGYzF1?=
 =?utf-8?B?amkzZXVSc1lSL2JLbFpHMXJjb2VpQUI0cytGSzBDTis4NWt3dEVoajdnM1Y1?=
 =?utf-8?B?MnhJYXU3LysrcUIydkRoWERBNVBRZnVXc0szRkhGK21UeUVONGNwTUpTZXMx?=
 =?utf-8?B?ZVFkdlc4emU4aGRoYTIwQUVwNFI3TktNQS9KS0ZFU1ZseE02Q2VDMUJDSzIr?=
 =?utf-8?B?TjJJUVNBZWF0WWcrL0xmTk9oOWNNb2lxTGhidUtpWXZvK3N4YjRoa2lrOTk1?=
 =?utf-8?B?VnF6Vk4zME9DVnhlSUZDdmUrVThnUlFzWWxrbTk0c3pLdW1Hc2NXU3dsR3Vq?=
 =?utf-8?B?VlhRRWpDc0R5RnBLY3VYOGptT0puOUZGRFBpRFhpUFp1RHlRbjZDV1k2WDJT?=
 =?utf-8?B?aDd3UUthOXBFRTR3UDFpbFNsN2JXY2lUcEJraVphQ0ZvMVFseFk4MmVaTStx?=
 =?utf-8?B?ckFHaFRWTFJqU0JockZ4UDhKUUxndmNqN3Q3dnQ1Y1pPV2pYQkY4NlNZWHU1?=
 =?utf-8?B?OEp1cS9MUDFiUFpEY2prcnE1S25jUlJzTVNlZXc3OC9NeElYcS8xTVhWRkVV?=
 =?utf-8?B?alg4OWxRcEVMNjN1N2tBSmYwZU51WDdWWExadlhKSFd6d1JPMnF1UkVXYTBw?=
 =?utf-8?B?bkZJN0N0bzhwWDlneU1NYmh5emVLUy9lQ3YyM3BsZTl1L1lwSk1tbHlkU014?=
 =?utf-8?Q?JAhkGp66T/ImxcmaPxHBMBUInUel86gEac0PDY1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cffd555-6fd5-4b37-4d5d-08d988c04327
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 11:55:59.4481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4Pdyoj39gGbEXsZvSlHCPlGIK2PbyyjIG3LAZyzt44Gd1zpbxV9tRdQqDzuyqQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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



On 10/6/2021 3:21 PM, Nirmoy Das wrote:
> Check first if debugfs is initialized before creating
> amdgpu debugfs files.
> 
> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Sorry about another miss. There is one other option added in the patch.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a24c6f7bc923d5e2f3139855eb09b0d480d6b410

"
config DEBUG_FS_DISALLOW_MOUNT
	bool "Do not register debugfs as filesystem"
	help
	  The API is open but filesystem is not loaded. Clients can still do 
their work and read with debug tools that do not need debugfs filesystem.
"

This doesn't work under this mode. Guess, we are not worried about this.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 6611b3c7c149..5497e2d31d1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1617,6 +1617,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	struct dentry *ent;
>   	int r, i;
>   
> +	if (!debugfs_initialized())
> +		return 0;
> +
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
>   	if (IS_ERR(ent)) {
> 
