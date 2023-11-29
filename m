Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18ECC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 05:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5F910E5FA;
	Wed, 29 Nov 2023 05:26:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AA710E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 05:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGayjYyQqVrI3bu6/776sNF+OrQ+Par9PVAaDHwq4YhkG3SJ6pUTcFHQGlvWdL2QLzPlL9ccQctjnB0ThskW1e0i6BvuoTp4tKt8Jv7eYKQ88VVllTzG+X5YgO9nicORqjPtf7Hhuw3qM1dZlX/CN19W+5is7S7C0eEq90ytoSMs6fg7hi6HgS+QEZYjQuF3EjOJuI6MYaUzYSGIWRLy4OZ4aLG8RVU0qpElpN0t7Sn7jmVpTYh3r6tciholK85RwXJCRZeTFmtcu+biYynZMaxRw2o9LtKUTHYJpTFvuOWEjkb3WKQ07p/yxqtenfMhrnrtuUytRV2urBZQ2nbI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H1xlO4M6P3nxJD1ZKnfTzLmrMRuGowI1rzrwueq7AQ=;
 b=TA5Yqj3sreCLOsIUDQNoPWXgmXHnHQWuts+Dnfzc4hh9idppiskI3mKbBpM4O56+kO7AjIB3EBFRpA6S67vKpSQESbySvP32cKcfkZksPMnfO0iyAhYYkRWxy6jBko58hOldabUBoSZLTLsF3wkM903opAgx9is1nk3HCZoa8YrQNbFMLVz6lAfnDVSgoZDhGTbq9Xz5ZKolKsT+bMDsyojVkj+mCPutsIlnQpbiam+1ycUlSsOkeIINqdSz3keeYKv9ywX/iKg3cV6gwRJHmGSykNPofOA6c1RYbjn4/q1GxuqMpuz/n2I5gbXopQMNiYkOwaHscdRU6Q8qxEQpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H1xlO4M6P3nxJD1ZKnfTzLmrMRuGowI1rzrwueq7AQ=;
 b=kBhyLOwNjb3ZefJPMP/D9d63Q7XHJ+HO+QwamKVda3kzi1onvMyBOrZM/2dBwJX7yYPuo1UjcZCaco2utAD5VmpKIlANsmEGa+VMKezK6ixl/PP0W8VcYunQfon6wcrF1W66nS425QQlc9Qsq2dlpsIoFY8V5PLvPoVrmrAZB3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 05:26:11 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 05:26:11 +0000
Message-ID: <0002e2d8-d245-4535-bd06-671b2b3ff61d@amd.com>
Date: Wed, 29 Nov 2023 10:56:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: PSP_VMBX_POLLING_LIMIT too big
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, asad.kamal@amd.com
References: <34dd4c66-f7bf-44aa-af8f-c82889dd652c@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <34dd4c66-f7bf-44aa-af8f-c82889dd652c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: eb97f4d6-3139-4572-fa8f-08dbf09bb269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xL8RoCiWPIHMN9q0bwEe2dQI0DifL+tNbazGyhZVulbS52CPX4tOQrW1TflpFg/678PyqKhfZTWzlcVLsbv2gnDOLn2SSl5EFjIUjeILdZjSI/sLXGnZbvuHahfiepnoUXblv9enTO7EhOdPhHfoYO0XYyn1i+Go6/9mB3O4ZyTyJlr8fBYRsJ4y3xcGUKr2utX5KG2fOhhQOc65RfWL2m8iOt73Hs6d89ciSwJhep1/kB50lkuJfsdrBM5aoHstaK44P8mEsDDEEFdEdUy9+AEQ0gYqAHExRuJp9qLoEWDjL2Y44jjP072UwVYVoswoq1Y3LifSzUIDExrs4fiI0qxbitVDBALhYdZldD42zrBYT0FOxyDXxupgfIdY3F8bQWpre+XBgwypTZIvyGSUzSIoSTPqqT6o9D8vnsCLMxbVGmN1x5onDGMBbJBg/Mqpn2dItgzya0aOW/JJc6KYakwd+VEXxQrwrSvCdrOYDnhUdfU2+QfrZoSxvRFyhnRaxjKWV+xycsf4OSWWIpVqIHb379p4fdUeKTL5+FQNh5I0L2irS/JKyX5N/DDVqGXwTRI3diwtBwNz9bEDSc4CpB5cTWfSxrXhiQce3peaLrZmbcJTprIusoWHqKbz9vTEr9q8J3k4xEnve6VdExFUgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(7116003)(8676002)(8936002)(31696002)(6666004)(4326008)(6512007)(6506007)(53546011)(6486002)(316002)(66946007)(6636002)(66556008)(478600001)(38100700002)(41300700001)(36756003)(31686004)(86362001)(26005)(66476007)(2616005)(83380400001)(2906002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJ1N3pmQWRQOFUwYTBBdUZXR2FLUm9naDdMYTdXbGJRMkxtV2hwTVcwb0NI?=
 =?utf-8?B?ZVNRcm5DVFZ4dDJaRG14NTJSZS9oM0gzZnRIRmZ6dzVSZ3lWK3FRVTV5d1Rk?=
 =?utf-8?B?U2JJWndXb0FETzFzSndQcTlJQVNRdloyNHRwdlk3V0pIaG8xa0lHcHptVmJm?=
 =?utf-8?B?MzJXVUtsTW1VOFl6NkJnL0lXaHNlRjBJUndqVXVHaldoSVBYVkFJWFc5Uy9j?=
 =?utf-8?B?MHRkN0wrc0J3Smt2ay9JTERtS2NyQzQvRmF5c0ZVMW84T3ozNjMzOGVEQWsy?=
 =?utf-8?B?Vk1UQjZUZ3diWWFEb05ER2VreTljeUxtcGphL3lHbHNnc3VhNzNzdUx2akpa?=
 =?utf-8?B?SXJ3VkdOcHkrelFBK3VGd0sxbVhONUhzT0h2dnd1bzdYNzVjdDRTRkg0WS9B?=
 =?utf-8?B?Y21aaVNuaGY4NktPS0dFMiticWp3RHNCZ29lSXBTMGVBQVBKQWpIS3NSTjBr?=
 =?utf-8?B?WEFTU05lUm54YUhhUWJUeDc3RlBJdVRjK2hxSWIwRy9EcDNNTUNYWm1aSnZ1?=
 =?utf-8?B?MEJyQm1zVkFXdjZQd2I0aUV3N2IwR25ZdmVlb2djQlQwaSthbDhGSzRnN09V?=
 =?utf-8?B?NTJDb0xoUm03c0VCT2JxMHNWZHgydUQ3cUpLem9iaEU2NFNTMU1pL1lwZGE5?=
 =?utf-8?B?amdTd1JZb3BJRlY2eEZCTnJhTENoeGFzdWtqMEhGQzdnWW5EMlg5Sm95SkYz?=
 =?utf-8?B?UzVUQ2FTeTg4ZDdySlp2dDcya3Foc1REYjIwMWRuU25TbWlyQndlWFFrNFli?=
 =?utf-8?B?cGZIZE1lT1lzV2ZJMmZuK0xHQkpNeUQ1RlBoMDdBTTdnL1BjNGRpeGh5NHUz?=
 =?utf-8?B?UmtxVkNzTUZXNWV2K25kMWlPWWU3ZGovZWVKOGVwbU5MQm5oNVJaL3UyMTZh?=
 =?utf-8?B?OUt4YnlnWWplZElGZTI2NDV2VGFSQlhqemljL0JaZE1aU1U4SzczMHJtZDZD?=
 =?utf-8?B?aElrNDl0bEl2SURHMDcwQ3RCNk9YRWs2b1RhK0RXSno0U0NoaTdRaU9FVjF1?=
 =?utf-8?B?YkJqYkJqbERjaEhObTFkTlR2TDV6cXloczRWZHdqdUxOTnVLbCtXaGxZeVJ4?=
 =?utf-8?B?MFdLT2N0c3FYbGVIeGhYWGdqek51cXhGdUNkTy9GSXMwcnM1amNmSE81czhL?=
 =?utf-8?B?aG5pZUxQcmdpSjNjODZ1UmpWZjhNbDJzRk1YSnFJYThnU0VSUXVxZTJqQUVW?=
 =?utf-8?B?U0lHU1B1TG5ZMDl2MjR2cXVsLzBNNzZLVEduVFQ2QSs5V1ZpeVdHdnBQZ0Yy?=
 =?utf-8?B?L1Buc21zVWI3cGF1T0pPdERSaEhRSnNEMW5DWkVNZ3UzdTNPYXZYRnBXMWd1?=
 =?utf-8?B?VDIrN3UvT1FlQ09SUG5TWkZuWVYyLzZNd1VMY2FvdjA1TjRVanVoRzFDNGZz?=
 =?utf-8?B?RHZhY2pYMkJ0dExTb290V2JCVUVtelR4VXNjNWJRcVRna0dCYVNGcUhTZUo3?=
 =?utf-8?B?clZDRmpVMDAvM01BVEFtUFplNW9ZNTQ5N1dGMkVsWjJCNzE0bDdRWHhBRWFo?=
 =?utf-8?B?eTBpWGlmMFplK1U5b2xEbDFuWTBwUWF4VjdqK2NmTUc3Z09PUEU5WUE2MVRk?=
 =?utf-8?B?SzNPbDRSU21GZUdYQUJvZ1JOZThxU2UyWHdQZEMrNlA2TnpNckliTzJpN3VX?=
 =?utf-8?B?NlhDclRyekNTSGdzWnFsMm9CdlJ4VE1aKzZVd29yZlN5MGt4UGp6YmZPMi8x?=
 =?utf-8?B?L1d5aWJIQ0xkcHB3cXIzOU5aRHd6MWdJemJxWlNNVzFwZmJhblVNakFGRXBo?=
 =?utf-8?B?QUNHbXRyOG1tMDh5SHNTRUVrZEJJZHkwbERVYmFrS2VLRjgzVkVaU0xjT2lp?=
 =?utf-8?B?dU5CK1NPb3AvaGgzSVNMRk5lenh4cW5RZG1NcHlmU3BYMHFNanpPZyt6Q29r?=
 =?utf-8?B?Y0NjQXRqeDJ0ei9PZnVvREIvSzB6VFhFbjRwOW9rcFpZYXZNK3hYcHhJbGVY?=
 =?utf-8?B?MkRzMFZxZU5ieFlSSlYwQ3lEc0c0ejNyTFJrb2FDazg2SHpxKzZKTzRVSi9t?=
 =?utf-8?B?Wm9zb2o4cnlGYVRadVZFazk0WWFxLzIxYXl1a0g4MUkzc3ZybXBBV1NkczVZ?=
 =?utf-8?B?RklycnE2SGh2MzB6NStBY280Zys1amdTNE8rRjFORjRUOUMyMUd3eXZTVGtp?=
 =?utf-8?Q?aaN/LhuAFo24+2aYxC9KyQmpX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb97f4d6-3139-4572-fa8f-08dbf09bb269
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 05:26:11.0623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /27vesLE6AVNYFApiBgvix7T3oNOZo9pqj6oYu0aic4UUyXpGVjonYa7aKT8pNFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/28/2023 9:51 PM, Mario Limonciello wrote:
> Hi,
> 
> In amd-staging-drm-next 46fe6312082c ("drm/amdgpu: update retry times 
> for psp BL wait") and upstream a11156ff6f41 ("drm/amdgpu: update retry 
> times for psp BL wait") the number of loops for 
> psp_v13_0_wait_for_bootloader() to try again increased significantly.
> 
> It went from 10 loops to 20k loops.  Essentially this means that the 
> function can "effectively" no longer fail.
> 

PSP_VMBX_POLLING_LIMIT to 20k is introduced by this - f2328c2ba0e84 
("drm/amdgpu: update retry times for psp vmbx wait")

20k is too much even for PSP 13.0.6. Will reduce it to 3000 (~5mins) for 
13.0.6 and for others keep the default 10.

Thanks,
Lijo

> I've got an issue I'm looking at where runtime resume for a dGPU fails, 
> and because of this change the system gets stuck in a never ending busy 
> loop instead of cleanly returning an error code to the caller.  The 
> outcome is the system appears hung while the 20k loops run instead of 
> just the dGPU failing to resume.
> 
> Is this 20k value really required?  Or can we reduce it back to 
> something more manageable?
> 
> Thanks,

