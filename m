Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40953C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 08:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C558F613DB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 08:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C558F613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D876E219;
	Tue, 15 Jun 2021 08:43:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BA96E213
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 08:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1jZsGQYU8WWI9BJVmHFAdJ0jBXnQrfcrWVPg5sC3ixOxk5gxKRpLibl652456g7pCWnM2yHJ3ICQdPSdzhL5/hBQU+eO1EB08yvC25tUdTgYTyOxWiWIOEPTYu+5Fpw+U4EGzJA7fAM0aRePfLWiq++XXgIe7Dy8J/+7+j+rhdAjY/3dhTZLk82W1OGBTcwyeminuNf7Bf2AXCfVjIC0VMLDrDgd7TvBmo/b7ceoh9vMelULTjSxTF3vkalHOxuQ0dsPh4ZFONCTZX8XniLvx7xoA2yb6y56sQZrTXtdXp68SydUuQ5FU1j75IyXrNTQa+V0B+wmBrjcL668uhxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CYBV5tLScxDlhR7hgU7K8Tqd04+B9nHpfAvCPCvbWA=;
 b=f8qU/goFthJ9ilz0dAhiGYCvPSK4L96DZM6JaQJZlLYGxbVDeXJeoSBUk1ce8fIqIWFsLzBbZ/ClWuq2YI8eVvALGOvOGh9RZHDn88jCJ5vqLf3yBbsGYyk1G57to0YrGUb2UbmDnTngjFLNFc81xi0c0Cc+yHe+APZWtCUq6On3R1Jr1ofJrL9VO6OfuXY6dOT/eHtufSnmILizkygnzbHGivjrl6Xpqudafo25+T5RSaN0b01JSVK6eTnbsFEZy9famJjXZ5bhZ0N4uZ3oEs77aRPSScsGKCZb3yiUE+qlcfzT5A0pUkj4JDqF5ABuqepBzsyOOrv9yCvaw4MoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CYBV5tLScxDlhR7hgU7K8Tqd04+B9nHpfAvCPCvbWA=;
 b=kQ8bYY0G4EA6QIDE6dZfpCYg0/xxHRM6SJyfoP7cb1c5WlZEd6yAw0fe+3ZNzjEQuWDIIMQkYfihRg17Jv8EWt9XgQiYLyHT9gLeY3xg2Rg6NPAPKh3g36R+p5nuRQGWJPwk7oO8doCpxSieD6CpQZyHjQI0YFYB54gVUUEYYcw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 08:42:57 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 08:42:57 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: parameterize ttm BO destroy callback
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210614192653.18239-1-nirmoy.das@amd.com>
 <CADnq5_PZtBA-iXC1LcpGvi-xeMtx8QkUxY5_m_zarWsoeuufBQ@mail.gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <622ab6f5-3597-66a4-9953-74e79e02f102@amd.com>
Date: Tue, 15 Jun 2021 10:42:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_PZtBA-iXC1LcpGvi-xeMtx8QkUxY5_m_zarWsoeuufBQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f25:c00:389e:e320:3bf5:cf96]
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f25:c00:389e:e320:3bf5:cf96]
 (2003:c5:8f25:c00:389e:e320:3bf5:cf96) by
 FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.9 via Frontend Transport; Tue, 15 Jun 2021 08:42:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 423f2257-56fc-482b-fad3-08d92fd9934a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52638DF6F48214A94FDFAF898B309@DM4PR12MB5263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7vzOljVNQXq1HF6lkx3uLQv+iRYHHjSh4stN+FgX97kUkxwHauS3l4gz4zfgLVXe3nxuy/Ynz6HaadrfdhoreG9JMQ/4lLEQF52zgRAOHz/gIKeTcJG/FUZ0qUxo/xhJ1+O7k+ATvouFi4mp5/IXO+ixEJqcDsZfJRNiZdEAdXryPkKQJRC+proS6tJSzk10KguRLNAQIc+7gQy2uKQgtz/HVr54cVncPVc8/bJV/m9iZ+pH2bBEYCRr7lc2IZdKpI0r/Wibul/kSTvhdlmCi7Tvn766XhMTwY1TahXnhMdga/S5QyJcppK7bVp88O70H+JRqmoNv7/cTw3HfudA1a1uyhJR7pf69EadePr2DUTMAq6h+qxkkOj1ix+i/CoElC7dLAfwEfhohhePkCfMKpNP2h/KQAOmOOY2DvTqXvkATLCmGcNsFnx0MuIMZNtSZOQM9JOps72IVSjrjYzzxpPLALfp0obOnduQFaNKux9U6FyTNsnkY8yJCICt8r504BT0zukiclduLY8+k8/caUgastJIYtA5ZirL/3aPDAlwtBabyFY77TllVtgOo6R5RraYDQlvw+iacQ2G1r1y0MsnA7sN4lejjl9aP46zXROzx/K893azMtVQ91hobS67zMD+xK4yOeLRU61CpKBSnbhfS78CzhM5EgJUCSkN0X7G0I9+evdwkF2eBEKlKOUz7iPjgTzyanh3T6rbU4LNAbSTwIJj4eprz51YEA1wcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(16526019)(6486002)(66556008)(966005)(478600001)(66476007)(53546011)(31686004)(66946007)(83380400001)(6916009)(4326008)(45080400002)(8676002)(38100700002)(2616005)(2906002)(8936002)(316002)(52116002)(54906003)(186003)(36756003)(31696002)(86362001)(6666004)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdYV3N3bzR6SElTTmJoY2hXd00reWw5VkxxSysrOVY4QnVpSFh0QVliOUds?=
 =?utf-8?B?Y25YWHpNdWpkWG9rRU1SYUwzdG4xdzhTbTlITHVnN2pjMllvaUlaR0haQTFG?=
 =?utf-8?B?V1V2UEJqRUt3MDhPK1lPVE9FTjR6Tm0yeXJLVHZ3ejZTMXpneERkM1hQaDJI?=
 =?utf-8?B?QUtEOERjVDZtekdCV01WbHNDNXo3QW1DWldkWVVmcjJqOW9QUEtNQUpHNENX?=
 =?utf-8?B?RFRJaG5VT2t0UUdWaXc2VTd0UXFNemZXMytzbWhrbVlBcjVoV1lhV25xb1NJ?=
 =?utf-8?B?NEdzRG1nemhtMnZIZkM0WFBiTkpXOFNwQWpDN2xwYmFRS21BelNLUkhrbndw?=
 =?utf-8?B?MXpyQ1lzTXVOaXI5b01aS3p0YmRiVVRTOUc1WGRHZndzUFQ5K0wybTRxZDFV?=
 =?utf-8?B?OThjVWgreUhTUFJBV2JVbGVGWExxb2R4STFrZTgvK1NLK3NjVlpqYVY5enJz?=
 =?utf-8?B?OTBxeklubVd1OFFVWWdkd2VmUU5QOG5iZ09rSUxWM3B2SXlvcm45OGpHMHhF?=
 =?utf-8?B?K2ZIcDFPN3d6N2hMdCtwOEtTRTNRNlJBdVFUS3E0eDVDWVJuWmtZL2hlc0tG?=
 =?utf-8?B?cGErK1ppMzA2c0ZwT1RtT1JzU09OcU1LLzlRT3FNQ0Y4aUkwY3B0VHNtdGpw?=
 =?utf-8?B?VWF5Ulp4M2lzT1RUSW0yR28zTXpQUHg1cS9lR2xpdElkeXA5dkxkQloxRzJ0?=
 =?utf-8?B?Qnp5ckUwVi9nWG45YlN4RW51ZkJGc2NjSDJsWFpMR1J1Q0lpSE5BZC8wdGJJ?=
 =?utf-8?B?ZkU1eTdJcVRiNjFmSmZGZERSSnROQmg1VzU1aWVuaFh4TlBxbVlCeVN5S1Yy?=
 =?utf-8?B?NnVxM0I1bTJqR0hKZlo4ZjViVlVpQTJhd3JQcERtaFNIaDhENTlRT3FrQ1g3?=
 =?utf-8?B?S1RRcUFnb1pXNXc1dkh2aUpjRVhPM0RaaDhic3ZMdGNNQjBmSG5oY1pEaDNv?=
 =?utf-8?B?R1hMNlRJWTVZWjREb3E4Yld4VHRqZEQ3RXFxU1NYVERNNHdwR25pVjJzYno0?=
 =?utf-8?B?U1cxTnRUVzFvcjFkbjZvNjRYWDlWdzVlU0ptamdacXBZSk9oS0lMRzVJcVZ2?=
 =?utf-8?B?UnE2YlVYSVVxenloSGpmSkNVTnBzeCs2U2M1YWJTRkI4UkZWeWdySWh6UVNa?=
 =?utf-8?B?SkYzSWNtUSs5L1QvWWY2cEc5UjJUWHY3cUdqalBVN0RTTFpnS2dHSkV5ckxH?=
 =?utf-8?B?dTFkSWtCTC9tdUYyRTZ0RTVTdjczWmxtR0xHSVdsNmpFdm5COTRzV2kxdW9U?=
 =?utf-8?B?TzF0bXArQjJ0K3V6NUlNYUxpZ2V0ZDhaYUZNcWJvWnBlbWw1U1p4blo5aWVm?=
 =?utf-8?B?VDMwZHdzK0lnbWNBQm5JU0wxU05tY3R2ajQwY1FsRDBTMFlmcW9Rc0hhWnZu?=
 =?utf-8?B?WVBZWGcxaWZRam5VUFNCZzM3V1lzN0ZmUnZFeWJoTjhGckpvelZBL1JCNlVN?=
 =?utf-8?B?ZTlucWJKcUlqY3ZwNkJ0YTNtT3NsemtrYU8wcWljTVF4eU81SEs3dWk4Szl1?=
 =?utf-8?B?clRtRlFCSnR1R2FJWldOd0hhWUQvZ2dCbytWTlJIQ3hncnBUQTlGbGdKZWFR?=
 =?utf-8?B?TnNYcWJ0SjdPdFRvNzJiMFlEMWJsS2dkb0ZKUTgwemF5UitvTUFCR255NzlQ?=
 =?utf-8?B?ZzJnbHJvU0QvMTBjV1d4Vm1nRmgzSkh1NnFBdkZROGo3QkNQdWxUTjhMd2l2?=
 =?utf-8?B?SGVtKzJQSXNLMVFuaDFiY1RoUS83aVdxOGtENVIrS0gwcm4xQjdHUWgxQTJh?=
 =?utf-8?B?ZFdlSlI2VlBGckR0UzJSWHdtb1dDMkFtaHRJbms2TmJPZThKQURlVGRZeGJI?=
 =?utf-8?B?UVN6T3Mzc1JKWWhrcDU1RXBkdDM2UFFMYjNXZys1TmhmWXIzaG5ucFo3KzZx?=
 =?utf-8?Q?6BieeVBVBCwP2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423f2257-56fc-482b-fad3-08d92fd9934a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 08:42:57.7568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNdP6E+zK+QtS+w/BEdjWZ4suY8sFhNDaIis7Inn7H+nC1rp7tpiG3c/eFbTpFdaOTncky+6nkpK3r/jh5pDgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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
Cc: Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 6/14/2021 10:00 PM, Alex Deucher wrote:
> On Mon, Jun 14, 2021 at 3:27 PM Nirmoy Das <nirmoy.das@amd.com> wrote:
>> Make provision to pass different ttm BO destroy callback
>> while creating a amdgpu_bo.
>>
>> v2: pass destroy callback using amdgpu_bo_param.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 52 +++++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +-
>>   2 files changed, 42 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 9092ac12a270..f4f57a73d095 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -12,7 +12,7 @@
>>    *
>>    * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>    * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
>> + * FITNEsS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
>>    * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
>>    * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>    * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> Unrelated whitespace change.  Please drop.


Thanks Alex. I will remove it in time.


>
> Alex
>
>> @@ -73,11 +73,9 @@ static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)
>>          }
>>   }
>>
>> -static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>> +static void amdgpu_bo_destroy_base(struct ttm_buffer_object *tbo)
>>   {
>> -       struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>          struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>> -       struct amdgpu_bo_user *ubo;
>>
>>          if (bo->tbo.pin_count > 0)
>>                  amdgpu_bo_subtract_pin_size(bo);
>> @@ -87,18 +85,40 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>          if (bo->tbo.base.import_attach)
>>                  drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
>>          drm_gem_object_release(&bo->tbo.base);
>> +       amdgpu_bo_unref(&bo->parent);
>> +}
>> +
>> +static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>> +{
>> +       struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>> +
>> +       amdgpu_bo_destroy_base(tbo);
>> +       kvfree(bo);
>> +}
>> +
>> +static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>> +{
>> +       struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>> +       struct amdgpu_bo_user *ubo;
>> +
>> +       amdgpu_bo_destroy_base(tbo);
>> +       ubo = to_amdgpu_bo_user(bo);
>> +       kfree(ubo->metadata);
>> +       kvfree(bo);
>> +}
>> +
>> +static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>> +{
>> +       struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>> +       struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>> +
>> +       amdgpu_bo_destroy_base(tbo);
>>          /* in case amdgpu_device_recover_vram got NULL of bo->parent */
>>          if (!list_empty(&bo->shadow_list)) {
>>                  mutex_lock(&adev->shadow_list_lock);
>>                  list_del_init(&bo->shadow_list);
>>                  mutex_unlock(&adev->shadow_list_lock);
>>          }
>> -       amdgpu_bo_unref(&bo->parent);
>> -
>> -       if (bo->tbo.type != ttm_bo_type_kernel) {
>> -               ubo = to_amdgpu_bo_user(bo);
>> -               kfree(ubo->metadata);
>> -       }
>>
>>          kvfree(bo);
>>   }
>> @@ -115,8 +135,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>    */
>>   bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>>   {
>> -       if (bo->destroy == &amdgpu_bo_destroy)
>> +       if (bo->destroy == &amdgpu_bo_destroy ||
>> +           bo->destroy == &amdgpu_bo_user_destroy ||
>> +           bo->destroy == &amdgpu_bo_vm_destroy)
>>                  return true;
>> +
>>          return false;
>>   }
>>
>> @@ -592,9 +615,12 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>          if (bp->type == ttm_bo_type_kernel)
>>                  bo->tbo.priority = 1;
>>
>> +       if (!bp->destroy)
>> +               bp->destroy = &amdgpu_bo_destroy;
>> +
>>          r = ttm_bo_init_reserved(&adev->mman.bdev, &bo->tbo, size, bp->type,
>>                                   &bo->placement, page_align, &ctx,  NULL,
>> -                                bp->resv, &amdgpu_bo_destroy);
>> +                                bp->resv, bp->destroy);
>>          if (unlikely(r != 0))
>>                  return r;
>>
>> @@ -658,6 +684,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
>>          int r;
>>
>>          bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
>> +       bp->destroy = &amdgpu_bo_user_destroy;
>>          r = amdgpu_bo_create(adev, bp, &bo_ptr);
>>          if (r)
>>                  return r;
>> @@ -689,6 +716,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>>           * num of amdgpu_vm_pt entries.
>>           */
>>          BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
>> +       bp->destroy = &amdgpu_bo_vm_destroy;
>>          r = amdgpu_bo_create(adev, bp, &bo_ptr);
>>          if (r)
>>                  return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index e36b84516b4e..a8c702634e1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -55,7 +55,8 @@ struct amdgpu_bo_param {
>>          u64                             flags;
>>          enum ttm_bo_type                type;
>>          bool                            no_wait_gpu;
>> -       struct dma_resv *resv;
>> +       struct dma_resv                 *resv;
>> +       void                            (*destroy)(struct ttm_buffer_object *bo);
>>   };
>>
>>   /* bo virtual addresses in a vm */
>> --
>> 2.31.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C759d1f627e9f4253baa508d92f6f24bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637592976669056718%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=74RcdxNGmdFbtidZgHVcYPKR3Nycx4TKNQqfS9%2B6IgI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
