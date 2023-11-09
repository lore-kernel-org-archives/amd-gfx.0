Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3181AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 01:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C05C10E1AA;
	Thu,  9 Nov 2023 01:51:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A8710E1AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 01:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdqSfcvUVRu0NnEh9eqWvo9zGwV27q6qvrOvms9RB/W+AX/VMfbxjSrm3zn5XB11/c37Ot0YIDhRjgrU9dEqiCOv5kcrNKu8D+esw2tDllVJtuaSphOwhDWNY97g4xg/k7iU7vp0XW5V6VCVRTqeeDkNkLcXtWcq9a9zCwfHDXbeIy1m9nWc6Sj1J0fQ8U6xkrXDQTN6pM43dwy6w3d+nFMgAIbrLMC6u5Tyc5hsxhTe+bUVPn8L33h6xbPVq+WXKpmpJrIOXTuTsi0Ey6MwROJOSy2r4Jufw3szCHzeh3BdIbl1bTmEePOU+mEGwoBMpN6bqRZ90/wu4MPZxhurhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGZEHzrhVzbRftptsFQtqZ8ZwgNW8yoVI6uGrLEeS8g=;
 b=i8Y/i3HfWvjBgLCg5ZPhpFpILqWuk+NcxDFGJQbcABB5rRMPkxHrTS2Lb8miS7RtOcUif8jI7nabO71DXWk6f+9VdBG83j3wFbuMZz2zsWAmQrKd2kt5r2FNDDbFFXiF0JPajw6Ftgjv6HPPFJflZASVRQ5jxoClbqMm3S88TEDW2ezX8kYtddj3pMUNl75N/0Pu3zO6p0JcR8EYgdjvebk6KUye5FFEZtL3Xi5If8hRSgaS+9vHBCmxWqe2v3uc8mKMgdq5Xl5g8hQHqZn4bcUeEaIeoTSMqZwgn2eAJX2F9eqOmSIu5rJ+3YOUyecQ3kWXQj4ZXb2BjR9tWtgn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGZEHzrhVzbRftptsFQtqZ8ZwgNW8yoVI6uGrLEeS8g=;
 b=nAgmQWbaSHxqTB14JJ9qy/ur5whCkzyPGKrNObI+kcjq0JX7X4Sr2zSwo+UY6rlbXWLWBA/xy3ALUczj/MGMGLHtJiCU6NsknWvIHAofjcoSHAug/texy+YisrxTJ9zupMNP4F3STCNyPLlNH6kAQZNIc56BuJSVA4JH2gizqn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB4595.namprd12.prod.outlook.com (2603:10b6:408:72::17)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 01:51:02 +0000
Received: from BN8PR12MB4595.namprd12.prod.outlook.com
 ([fe80::48bf:fd82:2c4a:c669]) by BN8PR12MB4595.namprd12.prod.outlook.com
 ([fe80::48bf:fd82:2c4a:c669%6]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 01:51:02 +0000
Message-ID: <92c0e399-d464-b6c5-7033-f33e73a0037c@amd.com>
Date: Wed, 8 Nov 2023 19:51:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdkfd: Clear the VALU exception state in the trap
 handler
To: Laurent Morichetti <laurent.morichetti@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231109002333.7516-1-laurent.morichetti@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20231109002333.7516-1-laurent.morichetti@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::16) To BN8PR12MB4595.namprd12.prod.outlook.com
 (2603:10b6:408:72::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB4595:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1435c8ef-2125-4d3f-751c-08dbe0c65400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84FO2BofTH42nHilCsi5Qs5wZUmo/IBwUlyU74GYjeVa5WeX/ghNX3Mo5OsIcRSBDu+gniDOvISHTCDb+327yO2YxjpzQtKxGwpGQy4Eb5lSkzdBzuAuq8iJ50jczcF9GKPJ07UcX6ngonnhUxMo2LCak460pC4++SlEa2kYNFWYXy/9ukDGwuiGMhtTPJ2MYWWnN2Z9TD9ssbyzpIuzKuO5m1fFyKOlokU1Hr2Kin0v8uR3l7KRlqa74pfq37kbek4tlPG/mvpWORx8hWU54aAugVpOSBwSpw7J1QqWxNw07iFp4XrlrXAP3dnw5fXVb5s9z7D13O32Ht+QLdLNeOhNS4qVD66pcNst3lFguNb4ye0wnxy7MUNk+eCZTmUsLcwa12DOdrUc4EXbR+gFIotl+EfPcsjaUibZM2T0dQMygy8KsI6conEypUCj2s8Uqvlp+jrtZ7PauBqWEPdnNVEXzumQubSFqr6q0qokPyUCLbVDwtJsYN6f5neoGJBSlalLqsqg3SoF6BtdCx5aBLGX+1ZEPTn4FinuRQU+TwX69rmvQJRQ22HJIGM/CikbuhNIXZ4Rq035+XGAG1NM5J6e2J81qZ7pv6poeTa+DjyaYogjCVu5TuOTvH6EGyEYehYE2n1BfJH9n5ZFWgXK0II+bo/bU4nUd8LOcG833Q0W0i1OowDaxN5XkFDW0ZMP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB4595.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(316002)(38100700002)(2616005)(53546011)(6506007)(5660300002)(6486002)(478600001)(66556008)(66476007)(6512007)(66946007)(26005)(2906002)(36756003)(8676002)(41300700001)(86362001)(8936002)(558084003)(31696002)(44832011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVFdEhDYUdyMTB5dDVHb0tnUnVjOGlCcGVFVFBHS21FSDd6ZUd3MEh6WTRi?=
 =?utf-8?B?aXBDNm1YMTBjcFZPd0trOTc3OXh5THF3bnZTcUEvWHJYb1h2NVRYeENKY3Bo?=
 =?utf-8?B?WFp5VkxBM2dGQ1cvbUxRMUx4dkFkV2lZb3FEVVhDTGppMFhib21RaERnLzV3?=
 =?utf-8?B?T0tJSkZvdlJWdVBPaWNKeDBCUmlDNVV5N0s1MG93WE5hSkl1L01HQkh2UVM2?=
 =?utf-8?B?aVRWUWFuT2ZxNVBhQzJ6SlpQN29vR1JRZFMyakl2dm9leE84Q0grNXhmSWs0?=
 =?utf-8?B?b0pGUzA5U2kzS0dvcUMzWTk3R1R0WU95S3ZPMlIvSXRpVFV1NTZBRmRhRmdC?=
 =?utf-8?B?bFIvUm96WVBmQVlQNW1VUW9FaXFwR3B3NnhnMlRzLzVlL3ZGTGRrS1A2SGlX?=
 =?utf-8?B?NU1pODZ1UFJyYSt5OW9HRUNpZkd5bE1vMTNDQ0taNGIzQlptVFJoNkNpSjc5?=
 =?utf-8?B?QmsweDVhYzlPUW1vSnVhTmZ3Qm1iSStxR2dIYlFwakdQMVJiQW15OVorM3RV?=
 =?utf-8?B?dWFqNi9JSmNIM1BOMHRQaG1JSTY3OEJzelZ3aUtoeEhIcjh2dHMzL2F6RllV?=
 =?utf-8?B?MWtCYjVveDlCZ1dZREdvWG15VGExRVE3MGxzSlhiajF0ZkNoM2QwWGhCQWw1?=
 =?utf-8?B?eFhCWks0MFJ3bU55RnV1UHdhWkcvRmtDUjNzeVZTQkdsSDQvMTROU3RaS00v?=
 =?utf-8?B?NUFLOHQ3NEsyOC9jWFRCOWxRZXhpanQxZ2RaV3ZzVDdZSHZyY0hqbDRRRHZ3?=
 =?utf-8?B?QjJiM0hQQ2hjRGQvT0w1NEMwenlraENicHViU0hYVk5tTnZyZldWQTllUlk3?=
 =?utf-8?B?ZzltUkdxSHl4UUtKMEo5VytnakVoT3FtMHNrU3hhRXBxZTRGSDd1NWl4RDNV?=
 =?utf-8?B?clRRbS9vdTV6WFc3dUt1SEVjcnRod20xVGN0UlpvY1NLK3lhcVhWaXQ4elY0?=
 =?utf-8?B?MHZtVXJpVHdERG9adkk1REMzajBaYmxhZnc2UCtVV0llbDl1dVYzM3hVNjFO?=
 =?utf-8?B?aHc0YnI0T25xazFSSnpXL3RVTHVxNjBjMGlZMUtCWFluRDVveXBySXVjUmlS?=
 =?utf-8?B?V3Y0ZE9sVklPeHlRSTNwUzF3YnhYY3JUSXQvNnJXVkJ6M240R015VnArdVBn?=
 =?utf-8?B?T09jS29EeWtyTVRreWoyS3ozOTJDWlAvYUZYQWhFRjlRUGNxenlISTVJTkRV?=
 =?utf-8?B?aURkd1RGS0l0N1dMNDZQREFUUGtFTDB0UGtyaTBJUmowNEZCWTZBaXNmd1B4?=
 =?utf-8?B?RGl1Y3RQMnhMZ1FsanVtL2lhRWJtcy9pOUhCWHhrZTNZeEJ5anZQSFExd205?=
 =?utf-8?B?QWRkNnZESkdTRFMxZlhkcnJ5V3E1KzJsKzEwU3U1SFcrN2s0R3hWVGFZeTBY?=
 =?utf-8?B?eW5kakk3dEx2SDZnS2FGMDByZzVPMW1tYzZjTnpOTU5EaU5ZY0hBMW1Wb1Q5?=
 =?utf-8?B?TExqRm5vYWdWUThzeU94bXQyUERGNytqS0F5MUtNNlMyanBTUmIrNmd5Z016?=
 =?utf-8?B?NTg3Z2s3VWdzZlIwQTNsVmlMZXcveUFuVnlqdUhleU5jNExacnI3U1dtc2pH?=
 =?utf-8?B?MW5rYkYveEVLenJrUVZJUm5tb1pEZGFtUTJlWGdickZUT2R4KzdEY25RTWwz?=
 =?utf-8?B?cHZMZUptY0xxUmNOemtqZXlnM2Y1VVBaTHhmTHVXc2Vpd25kbXRBUzdaS2Zp?=
 =?utf-8?B?aUYvajVjU3hPb09CZFl6LzJQaGxXOG1aSEJ0NzMvU1I4UGpLeFlnRmpLWHU4?=
 =?utf-8?B?RVZRRXlCUm1jazJRL1JpMms0cDNXdnB1bHk2b1NybFlNYmF4SmtrYUc0eDdR?=
 =?utf-8?B?SzZhbmlVZGpvY3dBN1FjVURQdDE4OGFGZWNObEZWbFQ1dWdKY25rdllmYWdn?=
 =?utf-8?B?NDVJZVhyT2J2QWhoeHNXak1XUE5EdjBjcE1hN0dkNCtSRDVsc1ZVbnlVbXY3?=
 =?utf-8?B?SWFYSGJNZ3FrTGtpcE4rRGU0cCt0MnNTMUhpVDZ3b0FSOFNUNG14Z2JnNjUv?=
 =?utf-8?B?QlFUUE5oUGxwRVhrYnN6STlPcStmZ1lxVjRrTlNEeCtrTHNBeXpmR2FCeW85?=
 =?utf-8?B?bkxRbE1tQXltNHV5WnZxTkNwL000azdjeTdJRGlrR1dlRlZmeVF4ZW1BWnpv?=
 =?utf-8?Q?V2liGtU4WWDgsX5GarTMsOi0A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1435c8ef-2125-4d3f-751c-08dbe0c65400
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4595.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 01:51:02.2698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SCD+ixRB11U/ckXErdS4JiEiCojL9jg2zoGese1TOoMzdPkPKuM4WOWeHPIicuzJkkYKtn3ZO01eePGe4Bh+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
Cc: lancelot.six@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/8/2023 18:23, Laurent Morichetti wrote:

> The trap handler could be entered with pending VALU exceptions, so
> clear the exception state before issuing vector instructions.
> 
> Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
