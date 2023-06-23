Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C364EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 19:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38B910E0DA;
	Fri, 23 Jun 2023 19:30:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8DE910E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 19:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMDfaEF5mKr33xA3ZzDfqEbTJdU5sv+Jqyrb9NWf7msPMP8pWbCY0JAl4xHBU3w+Oi4sROHylxOgtlQcyvuHhFlhs3BnTmP2B0I/rGXBfju85UUtRMx+PwBeD1ymLoMGoD9HjpHpQ2w9ptIM+ULLGNjX/xBRS3UFton3tF4R/F82LV11PLAbpaNcII7WPsMamK3Zmlo2ReOdZy4G3w7yKlVhzbepzrmcbKHE1JR2pPJd1gRL+MQOWd45JVSOKrgDBTz8CYRmffaKtt0JH+rZH4D2iH/dZBaHk0tyVfZc6cPcp78eGq0XcSnOlTmPSG4MsnnN2R0YFd4nLniYuytz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfCBtWUaQ1K+Dx9awHZo4PvVDycDaT5PKO+u0Q9X19I=;
 b=VhINWpod+i7qIYP/ew/hRTPAdv4gW30AvQB760Ybhd2rDt6iceitjd+RWkvR6t9rKsYfvY3u6SDnw515HlarIZzz1E1uSeSbH6AAUDdHJpluYL23Lx8aWoCi4GdJ3/vy66LDEps1AiH0LLSo6MDzR5VtWiP/nhIPpHsia5jNRTgCZl2KqAbA2+Cv69myoR57UwdQjE/Ljz1KECk9vAyU+FcrD3J57Rk6D7Qa9uc1wys77dLRvVhLLY59tOaA2bjVlPOh8vkwu6hJHwSLhJ1rWxad21X2h+Ekz9CGH3/RFFTpCgERh63W9kJUfa6aCILmmB8Lp08aq4zwRwtae5rk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfCBtWUaQ1K+Dx9awHZo4PvVDycDaT5PKO+u0Q9X19I=;
 b=JjpJ9pX61IRbD8uRBB4eTyTo3PioVXl/aj4trHuubYdNN7JkplJM4jrhXCgE2u1pguAZ56V5rf2f6LmgDJjn4qPKO3WPz2OOhcRhUxskQEkbrjAI7nQiOrxgsYzAzNlsunRRBpNrnuPwmKAUC3S0/jPRYn/UkrnG7XVsiIZjZ7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Fri, 23 Jun 2023 19:30:46 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 19:30:46 +0000
Message-ID: <60b9b8fe-5af2-3fc8-27d1-0400ac8f6486@amd.com>
Date: Fri, 23 Jun 2023 15:30:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230622182507.25531-1-mario.limonciello@amd.com>
 <20230622182507.25531-5-mario.limonciello@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20230622182507.25531-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0845.namprd03.prod.outlook.com
 (2603:10b6:408:13d::10) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: baa377ce-bf7f-49e5-326f-08db7420577b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fnZcssHgjMuAIHfL+/X0NGDlxV7PntXEsPzoEfyay8pfJNfbwRwLTn518KfvAioihQmkvOSq+hdI95WYTG9uRJkpHnzVdDgplO64wuKccflWXLJtEB5WFHpPP/qOCw0lmWUP5fzWXpkobNUrnh/VldBKYLlKRc4iVjG1vr4wjSX6AlBVb6qEtDpYqMcCPAaBrFDpjB3nqtJR2GCkSNBs6rfFWRViz2EexbbRrQ8evQBcREFzPqeWibYBe1OEmdELr1fWTOHWb0T82MsViWPMHDftFOMUWmt4eeFyW14YzR5+H8h5RLZpkB2rq7gusKdiMmzB9aFJ6Ipw8VgyDWGaGPhp7RbKrDASOt+MqfxdOFv63cvSzFLwRI0cbnsAqEnRSpdESJ3UNWgK+lR/3IAd2cC/3huye7SlEzdafNSrCI5gLOC6TS+DVJ5K45VVpGCeqhF4t2eubEKYwKW6+JwvtgzYDkO5BD8OxOV/36cyZwTWxuAO/rZz1d0zCw1d2V9omlnwBTlZLUFSWzWeivA/N4cQWz346yy7f6bVIEY7WTZPY6Ncqe+g72hIhacShM2oM/UpvAGOgKn81CXrIMn46T19DC/8MxiOCRN+3uIFav6qMXZRR+QCVIeyrqoOzWlnr0sarCo4a7K+Ri2vH+gOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31686004)(478600001)(6486002)(54906003)(6666004)(2616005)(83380400001)(86362001)(36756003)(31696002)(2906002)(6506007)(186003)(66946007)(26005)(53546011)(38100700002)(4326008)(8936002)(66476007)(316002)(41300700001)(5660300002)(66556008)(6512007)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJUNlRDSjBjSzJNMk5lNWlWdWtObE96VnIwMDYvNU9JNEFsVFlvRVVpZlFu?=
 =?utf-8?B?WHVFODU3Y3RIUk5JbWM4ZE55SmIyZVZYTjdJYlJGQmdWZ05CT0NtSEoxTzI3?=
 =?utf-8?B?ZlY5RWVKZERtM2g3MzZUV3VTRjdjZ21NNUpxN1J5Y1d6T1crcUM4SVA3bzVN?=
 =?utf-8?B?ZXcyUkpScWJsNC9zZklNblMzR3VycE00L3h3WkhVSWVGYUdWbVFQRERHOEhP?=
 =?utf-8?B?aDIrSVI3Ty9mazRNeUVTWDVUZTVEQTlKRjNUbnorTk1FS0UzL3BPVk1kN1di?=
 =?utf-8?B?QmxWYitSeDJINXBGZnRvT1l3MXg3bjVCZ05NZDlIM0RLbDNnRmtOV1FRRkF4?=
 =?utf-8?B?VW1ZY05sT0hZL1R0c1RxZ0FkeWcvU3hBSXR0L1BQalJVQi9KYm5GaFBtYk8w?=
 =?utf-8?B?aEl1NzBmSFU1M1BNZjhOZkFleXVLZExaK2Yyc0loN2pMOHJUMGlaWlF1eTh4?=
 =?utf-8?B?TkZleld3SlNtYXN6a2YwMTRwL2k5bnlMUnJVUTBvY3hLdE9Ib2o0Z3R6UEcz?=
 =?utf-8?B?UUJjRjVFK3RCSGtBQ3dkVlRoeFJNM2FyYXVCamRQby9zeDJmRWt1MDlLUnNS?=
 =?utf-8?B?enk2VFNqNnJXK0QzSnM2T3NFQkdKY2pEUjhsQjFTSHpmQ05BYmFpWFFwRng3?=
 =?utf-8?B?ZmJGc25wZUtJZjZPZkJSVnhueWlXdHpES3lSQ0RRZENpKzNDYzA3MnNKU25n?=
 =?utf-8?B?c2pFT05ETlkyeXJ6ZTBZekpmMW52YWFXb3RyenJEdlVuZDNNeEZEczNOR2pQ?=
 =?utf-8?B?endUN1plVVRrakQ5NkcvT2ZzU2h6cFVwY1MwOHJ2bEw5aldVbGFjVkhlWSti?=
 =?utf-8?B?RVZSTlcwdi9scnYvU29pUktBS1pzeWV3N3hDRGtZR0wvdGFZSytBZXZENk1u?=
 =?utf-8?B?d09mSHgwK2pzMTkrcFh2ZDR3aWd5VStLV0lBVFR6aFhjbUU0SDdwL2FlL2o0?=
 =?utf-8?B?bE1Xak1kc0U3L2pUUHVxenp3bS9vUEVGSVdpZVNhRWdOSUtIZWpHWlU5Vmt0?=
 =?utf-8?B?eCtiSktwU0x1SCtpOVpWa1pCaUo0ZVQyYVF1TTVyK0hCVWZFcGZyV2FSSkJ3?=
 =?utf-8?B?TzVMaHE5clFkeXR4QkRrYnUyb2VxK25UUjN1bU1kMmR1dVJqMmFseXlucnBL?=
 =?utf-8?B?Y2tJTkJsbmlINnV5TGh2cWdnRjA3WG9ueXg5N0t1YSs1cEdTOGoveUdmN01B?=
 =?utf-8?B?OGN4MXd1WkFCUm1iNFdUYUVFaWZtUHpzZnFrUW9PVHNBOXFpWUZ6ZFAzOERY?=
 =?utf-8?B?NEdrMnc4SFJzTHRmYjh2bEg1QlNXazRXQ0cvdExJQXFVbUZhMFpvWk40U3Ar?=
 =?utf-8?B?UWV4bFBsYURGaG55TC82QXZPdDBwTnhsTjJrUXlYbVRSQk4rS21ZalphdExz?=
 =?utf-8?B?MmwzbGcxa2J6Y0xVb2ZQK09zblNlVldxOXJJQzROUjJTTmRMYjdycjdES3dL?=
 =?utf-8?B?ZFhKSWM0a05xalJkZ2N5RVVmcjBTMmZMN25GWnFhSHBuaG1oS1NUYmVNNTNS?=
 =?utf-8?B?VitXcDZHZ1AzNDlmYWZxbzhONDFIV1ZHUDRXcXlRYlN0dCsxVTJiV3ZOOEhW?=
 =?utf-8?B?a0pVdENVb1lTTDNkbDBxSDNTNlVRVVBRWFltR0lUUHhBZkViNDJtVE9pTEJV?=
 =?utf-8?B?cWVkWXVmbktoTnhtV0Nzb2FmOUd1ZWRvUkpseTVhVG1meS9WMTZ4dWp3Vi9K?=
 =?utf-8?B?TFhsenU1Z0RMNVIvWHpiQXVxb1hmQ1ZsdjBYVXVDNG04UmtnN0k3dzBjdVZs?=
 =?utf-8?B?VFpXU3h5ZHBLMjdRWEpNUDJvU3NFS3hBaEFxSDk0K0tQd0V2Q2RaMU96Z1lx?=
 =?utf-8?B?NVYxenRLZjlnMW0rYlRUc0hoL1BrK1Z6T0JtVW1qeWo0d2pmVS9XdU1tb1Ew?=
 =?utf-8?B?UER1RGxkRDhYN0hkQlFtdE5mcmlMWlgwa202OWp4YVpZb0p5MCs0UVlPb2d4?=
 =?utf-8?B?Zi9xYy9WdXBJRHp1SmprQkttSjFNMjFrMFhoaTBmSCtKWjJ3eDZsb0NBT3dq?=
 =?utf-8?B?YjFLRkxTZkEzRldxVURwUmRROE5nUmR3ekRnTjZSd0VNaWZ3WFh1a1VWZDdw?=
 =?utf-8?B?dnYzTllCUzYvcGxGZGhhYk9EcUxsalI3a21wbWdJTVU2OThUVTc5OUd5OFBo?=
 =?utf-8?Q?fjgc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa377ce-bf7f-49e5-326f-08db7420577b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:30:45.9791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epB8r6+vgq6nHuIFt8l96y177i+Jya8VWAa3akswXX+MgrmPMux9fi81bUzkqC9n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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
Cc: Sean Wang <sean.ns.wang@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/22/23 14:25, Mario Limonciello wrote:
> This reverts commit 33eec907ce0eb50a56dca621aa7310f7fa904b93.
> This is no longer necessary when using newer DMUB F/W.
> 
> Cc: Sean Wang <sean.ns.wang@amd.com>
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
>   drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index b9e78451a3d5..30349881a283 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -839,8 +839,6 @@ bool is_psr_su_specific_panel(struct dc_link *link)
>   				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
>   				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
>   				isPSRSUSupported = false;
> -			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
> -				isPSRSUSupported = false;
>   			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
>   				isPSRSUSupported = true;
>   		}
