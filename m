Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95060C25B48
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 03:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9C310E540;
	Wed, 25 Oct 2023 03:03:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A95710E540
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 03:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYMo+/KDNR8brlHEy2WDq0DPBqLnVANhohKZ82wtVdThqn8DBfbMLHBV5MsmJKHnqu1O0dXDjoc2/ZxkXQh8Y1wPpf1mmogC/t3ZLt2i/R72MeMc/+XUCmkPhn7R0WLT21fgeTcmT/Qbdzm3SP4+B7yVPPv6OYauqcj1sslAdL2E+Sv+NV4USIJSD4qDSydPh9P5UrzwKqLJ2TWBU/Q33rU+udbNebNKyN/q9rwxmA1HomFwSLDXWQ2ekaeznaHksix0weydwOkk5hOmp/rdYz1rYb1rea5GV4xUjRFY6P5NWmY57BXQ4wz0s9iSmv3P5xeOAHn9tnGk7zhSuNqVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA4z6V8wduA6HIghwb+uNhU3HU2wlvE/vIKv921PPo8=;
 b=cmIw3BlN9kVaMXXCVv8h/4x7ztkUbtkfGP9aUkJaN77KFpIpTaWRgqQSD9HyKV23Gfo8DXM1pgtwqJuUdZHrp+7ff4/iDGry7eOcpvWFyq8Z+nCG9KEa7hvEyIRu/PLDIzSgxaH5slpRlDeXCfBaXqiSNPXYSa/FJMt58e1/uvDHvJlw+rVdoy7rTvlXhlsKCLDWvFtr9aLKPrmiREmzBYHPkLIJd57AhBoQ6Set3cqBzeQhgsdRcBZakWOfiZg7u25KuxIufCrPmbVokDALJOxUXsJ2YuZRtjObmHF+sipuZp1JTsA+t+RwY1aObwN4EZpalzraQwM9dp91+k2tDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA4z6V8wduA6HIghwb+uNhU3HU2wlvE/vIKv921PPo8=;
 b=Kx+63VNQkOt1Poi6Qqno6qlT/TuxyXEHgcc+F9Xo5/FrBp9TD+BwifulDNXJ+IeM+Q6sV8v6Fh2aKrhBrAMXedoU/CE6fNwklqfs4Nxmz16e3XHCBTJo50ftr3p08e33Pxj0xCau5tpOR3xIj6QGsiPOshw3rwit+evAxIWGpXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 03:03:34 +0000
Received: from MN0PR12MB6055.namprd12.prod.outlook.com
 ([fe80::d8f4:cd66:a294:589f]) by MN0PR12MB6055.namprd12.prod.outlook.com
 ([fe80::d8f4:cd66:a294:589f%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 03:03:33 +0000
Message-ID: <e9583fdb-99ce-4e46-8326-b8ea0d9c86b6@amd.com>
Date: Wed, 25 Oct 2023 11:03:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd check num of link levels when update pcie param
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231019094642.20229-1-lincao12@amd.com>
From: "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>
In-Reply-To: <20231019094642.20229-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To MN0PR12MB6055.namprd12.prod.outlook.com
 (2603:10b6:208:3cd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6055:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: e94f987f-6566-47cb-8dae-08dbd506f8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zzt7FjeffaRofQSZ0ujNGpvb5Z77rpnXy60aGZk9vyYTqe5u00jQ5l+IlQj8y/rvF8k3in2H1w+tPo1e8MQYlOSzgutx1YHgMUXSx2o7VafqcgWRY8b3XdMakQyH6Tf2YCErFf7u5R/+eRRCwJW/cou22essMaG6cO7XJ9XTu5zIp6nT4kiet62jHL2cNxHL3yOHndbhX3v3bW3j5/OHdbHjeB2JHaVvvbPIHpZGELej5xiO+DwHtFKn1FC/1gWEF87EVgwwgPKVl4W/nhpuUmAEcwHsPhmTP04HSnLHj6Irv4SKeJ0uMImWAcfTzSEaC6CpWx79ipNu4EfeVy40glX7VgF/lrmLTl4kSfP+3gP9f2iIATu/Chx9J82UX5Qzt2oJB+j0KlksWqXPwJY/+7fp6dwRR6qezPzDX3YghxS+L+nl4YNldwE8FT0Xk65rI1Nppf4GaLJUVeV9wHMdcwvh+dkYo+KWS561hK/yOz4Eoi3tz9lGspPWsjTSlGL25b9mVG+bcv9MG6Oyl8CrqedatpZFfEXBmfHzAlx47PWN3g8XoIdWH4OXQFhHC0q5gkpclF45u1qpUQvNNnvZBjy0LMQfqUiN9+kwFYV/sSCVMu7wX+hkVxHbI3xDH7lDQ/5f8GUzKvARe3kIZ1IaOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(31686004)(86362001)(38100700002)(41300700001)(2906002)(66476007)(5660300002)(31696002)(36756003)(2616005)(8676002)(8936002)(4326008)(6666004)(6506007)(316002)(66946007)(478600001)(66556008)(83380400001)(6486002)(53546011)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlRocStyTDFNcmtUZWlwWVRhd0srbW1kOUI1RFR0WE4vRE45blpTa09sUTVE?=
 =?utf-8?B?VFZwZzF4STFUa0ZJLzNZWnpsVXFCdnh6dENXYUFRYlh5RURXak4ySjRWbjY5?=
 =?utf-8?B?REd6Sk5BU3lvaDdYemNjMnlHLzFYaTA2UUlrQmo1TStIbEdBMWMvc2pXOUNS?=
 =?utf-8?B?RlZpUFdBZ3NBd2hCWmdPUmxEVHhzVVo1cXlpdUZtN3NiRUNBWXpCYTIxRTE0?=
 =?utf-8?B?U0QzZEp2TE5ocHc1VktKUTgzSlh2Z2g4V0JTRDBYaGJCY0ljWU9YelpQS3hM?=
 =?utf-8?B?ek5MNW9IUVRaN2s3SFFuR0tMcWxTNFZtb0o1OFc0aUZzb0NnRE5CVlJPY2g4?=
 =?utf-8?B?WE5xYTA5aHZoaUdYRHZhaUg2c2EzR0VIL3VEUWFITUpZeUQ0Q3hJOWdWZ0tv?=
 =?utf-8?B?Q25JU2x1UnhGL256S3BzZ1ZQcTQzVUNxeXp1Y2JLQUNsSTErN3NMRXRqSlB5?=
 =?utf-8?B?RVB4TFh1T3Jjd0N6YkRtZkxDVXZXck4xVkpjcDAvTlU4NlBhV3VwRFlhSlFD?=
 =?utf-8?B?WTF2T0p5Q3g2UGg5UnZRMk1zRG5lK2NDdkdIcnJzNndTemwvY0dyc1N0M2VH?=
 =?utf-8?B?M3U4OUFOaDNTNm43WlZWU2ZzaDZFVkJiY0lrSzRJTkZmZFhwTHhCSkIyd2lm?=
 =?utf-8?B?c0tNRmdHMmU0MW9vcW1HNUdpSUl6RVpQSmV0MVVLNjZQL3J3YXpPMlZ0NGFZ?=
 =?utf-8?B?andoY0FLNnJTcE1UdWZFS2hPemlhT2JkMXNHcFpPTXFRcEJQWjREOWQxeGx1?=
 =?utf-8?B?ODBVcFgxdVQ5RW82RExMeGdOZEYzdGZKclk4RXBHVXRIRHZLWFpWaThIK3hq?=
 =?utf-8?B?dXNOSTFvQ3NxRStGUko4aDlPaXF2NTNyN0MwK25xWnNidEdtcEZBL2p6Q1FM?=
 =?utf-8?B?ZFZwYnNIQWR5S3lxangvQU90OG1qdEJjOW9ZbHlydGNoN3M5a3daczBhd0h1?=
 =?utf-8?B?WlVyVWdKMmYwdUVkQUd0azUzQjNiejVlaHRYUTFzY3E1SnJjSHdxUktJL3lZ?=
 =?utf-8?B?R28ydDdhdXlkaWYvTHZmODJydnRqQWZCME9GTEZEZ09uamNNSXhPeDhTNjE5?=
 =?utf-8?B?NGJxczFoTzg1YVRZZlJneDNqekNtcFpLZjJyajdJZGhPcDBSd0FPU1JDTHo2?=
 =?utf-8?B?Q0lHOXg4d3diQ3NCMU1HVEZXOG81VzErU0FuRkU0TUtydGVrVDVRN0wwMXRw?=
 =?utf-8?B?elc1UGhZY2hLUFkvZVNqcldEeWpyZzA5RnBBWHhsQVhzdFROemFSRWpPQXlV?=
 =?utf-8?B?MkVyeXhjSXhDa2JDdVFqU0FiTURvbmxGS2xxSW1rZW1oNGZ4eXgwem1LMmNW?=
 =?utf-8?B?MGhueUpTVDNqTFpzSlBaNVpMZ2pxUmN1R0p1eWgvL1J0UHp3Qi9mbWx2bTNM?=
 =?utf-8?B?bzNpdHNQOWNSWHJXZzBLNnRqRXJUckhESjlocXVWRnZ1MU0rNkpkdVJtdU1S?=
 =?utf-8?B?UVl0U3FDZkgxRUtBZ2QweW1PRlRDQnc5eW9zWnN0Um5xNE1kdmxQZHpZbTNr?=
 =?utf-8?B?NlZ3TnVMSzNtZ3JQUjE1REd4T2hUMG1UZ1dTUjdXR3kyWDROQWRQQVJleUU3?=
 =?utf-8?B?ajE4N1Y0d0ZhN01WSFYzVUJpZ1k0eHBicjYxVjZpYmRnRXo2T3RhNnF5a1Nu?=
 =?utf-8?B?eE9HSWJaZE9oaG55aTJLNmFSTTJpMHJpRlZHUGxxMXJJbjdNVnZOS2trODYz?=
 =?utf-8?B?ZFpaUm05TitXVmw0Z1ova25OU2NkVUY2TFRRZWFDNGVKcU5nUnVPNzBjbHd6?=
 =?utf-8?B?U0xGRVV2U1lGMlY1TzMxbVczellDUHlDeGJ4V3A0MG9GUE9YMlZLK0tEYlJG?=
 =?utf-8?B?enhtVnRUUmZBZG9DRjBNYU5MYkc4cFJrdFpDTWx1WXBmaURBak11THZ0OGd2?=
 =?utf-8?B?MDQ5UGNYWTdMcDQ3bk1KNXcvRFpUa3pxUTFwTlZtY1dlL3BEckhpbS9uV3ZK?=
 =?utf-8?B?S1p5RnNhZm9DSno3cFNvekxwM0k5bEVEa3BSOHVoMHRBNXQvampMaG10b09X?=
 =?utf-8?B?M1BZSXVEdHcyaHduZXp2ei9DSTNCV3YveUJYY01xYUJUcitpUXd1T2N4ZEZp?=
 =?utf-8?B?VEI0SSt3cUZwQkcvM2FxMjJsNFNPd2c4c0Izd2RXUFRmMWlXRUdodC9YdVVF?=
 =?utf-8?Q?58p7ypHZg4TUZaM+Utch8mXO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94f987f-6566-47cb-8dae-08dbd506f8d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 03:03:33.6368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjxfFV6zy8HVrN15lz+XvO9gP7ld3Euvdvj7ZhO8FOZ8ii/6ZkyUemb9ukIA+DpuG2efrP0kzE7jmQhjvi5w4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
Cc: Deucher Alexander <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>

Best Regards,
JingWen Chen

On 2023/10/19 17:46, Lin.Cao wrote:
> In SR-IOV environment, the value of pcie_table->num_of_link_levels will
> be 0, and num_of_levels - 1 will cause array index out of bounds
> 
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index bcb7ab9d2221..6906b0a7d1d1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2437,6 +2437,9 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
>   	uint32_t smu_pcie_arg;
>   	int ret, i;
>   
> +	if (!num_of_levels)
> +		return 0;
> +
>   	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
>   		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
>   			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
