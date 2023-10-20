Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7EDC001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 21:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2627410E5F1;
	Fri, 20 Oct 2023 21:51:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CE710E5F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 21:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvTCbNUP3gUZVpx802ZEC7tPluOQNuhLuKqc2G97jZ8X7xewfj6Ti+IuLuOD+RSsABmxyYoNS0d+BPt/yR9XZmOGvt+PQaE5Knx1Y+qdNJTV8zk4gE9aatT/O9Id0RmWtmnXYKsFP0LxaylXbE5SiAtuwJWZVAXpCUiAfWT7Xd0FGhp/t34jXLrmQ8H2+M9AqETidaF5be0BoOMKMVhQ8pQ6SskvWk/lJkoYE13RlCyLbPqX2i+Uh3ZhuJUi7Ci8p5anT6KGrktD4Py66FY4VnNcykc9LEW3UTKxZi0f3DQrAQNwtyIt3TjOQm+j35IVgAZe7U0R0ELde2/edAjkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaLNbynjvdweTB/R48+bTCDaXhYRBtM2pNln0dQuuNI=;
 b=BV8OwOZ+eM8CFTAaM/T8oUESm90PPaNcVLMs6H8OpwkDLO5FvK6Brexmqii+8yGzGRtNK3LymJ3c7YduhRAmVmNuzh7H7OUToFTe5oe/IRk/8PQ3tegeD1NcNALUuEu6CAy6H/DswD+88s6Ma2BZQrdxiP9e2jUgUQCyG3I5cmE1kwHdBO5QPexNutpmomRslooY+6NrUJQGzhVyr2+bClBSl1NLBxHhchEQK0VLsNSQci3p6eSEqeqXC0+vp2S1xBQEF4TVk5HT5nImRhsowq1ZO6c5St/UyfDuLj1bLdS5ArW9/nwIS8/EZojOtPmYTm8Q3Bx9ToSjYIKDYg2kOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaLNbynjvdweTB/R48+bTCDaXhYRBtM2pNln0dQuuNI=;
 b=cDT9thmv947WJbm3gfhK7uGtp0XSm6Ye6g97RYDdcYPZUNtrwQRLnVaLyHXz2fgd9VDd7+HVNzVbNp++6Ajm+ZML+2gSW8/GhB9DOjVa0aliJkiW3BlftDRpdLWSezptFh/V6GT3ZKyqbbH1hc9BSUK5EYeNW7gLYqewWy3WItc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:51:47 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9620:780c:562e:33a1]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9620:780c:562e:33a1%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:51:47 +0000
Message-ID: <cede4c51-8a70-446b-bbfd-814afec1f3c7@amd.com>
Date: Fri, 20 Oct 2023 15:51:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix issues caused by DML2 in ASICs older than DCN35
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020213009.486473-1-Rodrigo.Siqueira@amd.com>
 <02750483-1098-4e4d-bf4b-7b731a0003fd@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <02750483-1098-4e4d-bf4b-7b731a0003fd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:408:e9::20) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb90d28-3a5a-465e-4fe8-08dbd1b6c23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dba1pKyozqDXOyO6Pt/NaZtN6R1lE/GCMG9Al4UKVJk21lQWA4h/VoauBLxjNlMrl4kklcpKoU4uKumEgWPvoPJ5LnuWwZQ1cFChXnX+7BZrMyBRmMfJRev7e6K/P40GFrkeYLqU06ANKYKMiX/U3oWJHoW+Bcmi1L83u+zdUH/qXxPK5mmR+08ogfactWYdN6SNWC8VynNzFo12vvGJSy55MCHfXHa4eAGSVhvrHpEPyJIum6qqHOFqbl1tykDg3xp+3pD5KV26jZbGgPC7ccKMKJ7k4v6zYWdw6n2SF61i0hddPfaslvUyC18RVipqtQX+StZIk7drRSxeAHTRSKfPvcNrl08q7lhIbfllmgoj5Z3dcmhO6TL2ZJsgl1+l75CWqWAM0S9pndqypJqELDr9FTXIrx58jjwr3S0LRDux+P6tGwYdZFmLkk7NAdfzC5WIhmg4wHafvi/qjDBLiMHltOJ4cgZYe0ikgHIRuSMVLNkzGx5FFXC84SG8Cu2rUcwYse3Etuf9a/CPAQIaz1OBqu9I1s+kIc+eai2MtTxZcrIm3OozZ4UxjI3RRsAH1UxjibLfQBYB1Wf7fRP0YOi+TDw+fUNwUGPoSOpfaQhIqQT7TMbn4tCCD002PESHJAoGZkXyoL+W4enGlzxUcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(8936002)(66556008)(66946007)(316002)(54906003)(478600001)(66476007)(6666004)(6486002)(4001150100001)(8676002)(4326008)(5660300002)(41300700001)(6512007)(2906002)(86362001)(31696002)(2616005)(38100700002)(6506007)(53546011)(83380400001)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNvcU5nMHArWnRBWDlMS2tVa2NKc3ZCTDcyY1J4SmZyMGl4ZWZ6QmMwNzJn?=
 =?utf-8?B?dlJGVnVJNnhsYkpMTUVwWmNHSHErUUpRSTJqR2R6MUdLempyNlUvK3pLckJF?=
 =?utf-8?B?OW1aTTBqK0Y1RWpNQTdjRmJyVFozS1VIK0xVU3RVa3pQUVR6R21kcmo2QWFJ?=
 =?utf-8?B?aWRUSVhsVllGeHcwUXdOZGRJVXgvaEVIbXhEMFNqaXZUOSswcHBVZzFJbXRn?=
 =?utf-8?B?R2x6MGNJbFNkWlR4aGtTb3dxeE0zNDVmMURDK1I4NU1jbHhreEFJanlOaUpp?=
 =?utf-8?B?dFd2b2NnbG1NbVlXYW9DL2lIckdKQ1Jxd2FmN0tqWUp6UncwWlc0RGJ6MW5h?=
 =?utf-8?B?RmlIQk54R1FUNjM1U3FnUFU3NXVGQlFsbnU4c1JtVUlkdlhnR2cyNi9nN2c0?=
 =?utf-8?B?REJORWZjdlYvSVlXbDlNNWxUdCs1RnFVUERQMzBuTm5ydm8vcDRUZnNBbXpU?=
 =?utf-8?B?RmNEVDg5UVZkaW54d09JRWYzKzZidXFjWmlCNjBTdGN0SW92VHh3eDVVSGNK?=
 =?utf-8?B?bDRsSGJsMFcwSmxmOFlaSVQyZ01XYldyZlNtaU9mSmVJYXMvbFlzY0hrby9O?=
 =?utf-8?B?YVhKcXJWdlA3UDFYb21ZR1hzWmhtQXlKSStwMkxCamIvaGd3MmpBRnZndEtx?=
 =?utf-8?B?cEROQzUzNHRBeU4rZ2NmdERoL2hhNlhZSDJES045bGFSdWRzU2lzbTVDakt4?=
 =?utf-8?B?TzhWWTNLS2M5anBlRkdpM0ViQVV6b1ZHV0UyOGZtNlFjTHNMRmEzNnYwc3dM?=
 =?utf-8?B?M0tFZktGc053ZTNDUVRrejh6STMyRnJtMUk0UnN2Y1Yxdlk3WEdwZ0NsUEM4?=
 =?utf-8?B?TUxRcnlqeDJMcVhoVHZyakc2dWRMSFBkaGhwN1JBek1GYzJEUllyVWJpRmgz?=
 =?utf-8?B?YWdVcnlJaTlid1BBMGNRTEZhTUhnVTZ3alJTclYxbVRFeXVSWk5rb0JrZ0U4?=
 =?utf-8?B?ZUpFNG85KzkzdmNMS1FuT05odXpnODAvaWpiU2F2RVdLK0lOY2tvOW5vcmtm?=
 =?utf-8?B?elBBTHEzdk9iSWl6c09SM2JBUEZMeGJIQitmSjVTaTVMdzU4M0p1bG9vNXYz?=
 =?utf-8?B?cFNZOXU5S1Z3eEhDczhxT1UvRnF5ZVkzclNqVjh5YlV0R0hsNXV2SlRhSHpa?=
 =?utf-8?B?clB5aWdJNWtZYlFlMWFLR1VjQ0VtRGZzS29SeGFRV1BtTlUrVEI0ZElXaW84?=
 =?utf-8?B?bTMwZHZzZTRKUGVVN3M3TWRGeVVxN2lVWXNMdkJnUXZrUG53TDkvRjF1ZlNn?=
 =?utf-8?B?K0dzTEQ0MDlvejZWNHluR1MwRzVxTnBJWDFLYjlleXdZOHB2Uzd1QXByTGVJ?=
 =?utf-8?B?WHJIRW1BeC9WbEh5NFVHVHgxNlZPM2hMN3pzTW1uNlA1aVVDMTkvQ1dDd29T?=
 =?utf-8?B?TTRNS1dMakptZ2owenB0dm5jb21rSVJIQ1cxcFYzYWlkYTFMMUcrYXZpaE1M?=
 =?utf-8?B?Vm5yeVNrYUF4VzRLWFpLKytlWVpwcVlOaExReHNEcVNmdFBpUThxTHUvM2l2?=
 =?utf-8?B?ekdCS3ZpVkhsRmdtc1hNRXBkanpHSlZ2aGZ3VlA5dzNIaFhXK2lYQVBWaDVH?=
 =?utf-8?B?RTVNL3lBU09lNVpOQVVxV1lHQjZTMjhXUGMzUnU1T0dNM3lHOGNzYTVqVUZP?=
 =?utf-8?B?RlNNZFIzS001UEF2Z1VuQTdsQitGS1JsRlRLMExWNFJPWDFvUTVXaHh6QnRH?=
 =?utf-8?B?RUJuR25acTlPMWVOWVVtTUIwajAxb01VNzV0NGdHMWNYVSt2M2xTWmpscFM1?=
 =?utf-8?B?NU5QaC9uQWFQdG5EQjloY3ZNblZwZWt5MnpiZkdEajE3RmRVQ2U4UUFtSllN?=
 =?utf-8?B?TmJVcGFGbXdFYXlkTU9lQTdQZHRoRUUrd0daTXd1WXhvUzJqcXpLWEFaSi9i?=
 =?utf-8?B?N0hyT2ZkSHZOZ29JQ01KOEI3Y3dqcDdIMEgrdmtUNW1FNURSSlg0bmtaajZE?=
 =?utf-8?B?SFBYVmNIU1NqbjBJczgwWm9XVCt5VFdtMWF1YituT2dlTVRQdmFhZlA2NGhr?=
 =?utf-8?B?cDk0bzVHcWR5a1pBYVczaC9MZTVqVGtGQTF3RWJFTllIOGxDNHUweTRTK1pp?=
 =?utf-8?B?ZklKeEtMVW14VkpKVlVYbFg5bTJobEdIRURjQXVLbXdqZDdVZVhxQXdOWC8x?=
 =?utf-8?Q?RNkHOos0ZfAAVw3CfNvIm0u0w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb90d28-3a5a-465e-4fe8-08dbd1b6c23f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:51:47.7740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPqoZJKndVWyv0dt5ufX8PZoDySVh8TKSAARhoXNY3FK6STSftTbMsF7CkjrVIqIGoOtGlM2lzruVSjzNJqDCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547
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
Cc: Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Vitaly Prosyak <vprosyak@amd.com>,
 Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/20/23 15:38, Harry Wentland wrote:
> On 2023-10-20 17:26, Rodrigo Siqueira wrote:
>> The first commit of this series just sets the variable using_dml2 to
>> false for all ASICs that do not require it. The second commit adds a fix
>> to the DC sequence that calls a DML2 operation in ASICs that does not
>> use it.
>>
>> Cc: Vitaly Prosyak <vprosyak@amd.com>
>> Cc: Roman Li <roman.li@amd.com>
>> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>
> 
> Didn't realize this would make the change much bigger but I think
> it'll be more consistent in the long-term.
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Thanks Harry

> 
> Harry
> 
>> Rodrigo Siqueira (2):
>>    drm/amd/display: Set the DML2 attribute to false in all DCNs older
>>      than version 3.5
>>    drm/amd/display: Fix DMUB errors introduced by DML2
>>
>>   drivers/gpu/drm/amd/display/dc/core/dc_resource.c       | 9 +++++----
>>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 3 ++-
>>   drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 3 ++-
>>   drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 1 +
>>   drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
>>   14 files changed, 20 insertions(+), 6 deletions(-)
>>
> 

