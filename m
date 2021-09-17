Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 12:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4019611C8
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 12:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4019611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 854E76EC31;
	Fri, 17 Sep 2021 12:00:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159DF6EC30
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 12:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Marz/V40rrPFjb+pHZbVs5jcc5sHucWpbKMgFQMtP8rhQcV9V5r5ViUhuIndbM5lQFUH+V+60Wu+C5AyqOjESEhatT/eB5stI+X2oPFpY/vxYdaUpfdsCG/mwIe3zetzWBaAXqF+Q2CEdWgRPS1ssufKeND1lRRh62LwBvClmhuMlPyEPwYw53/7mP3CrMYGKZwkre42AbJ4CJQVLQksiw36gqpG8khdM056oiVeTkyhGgeJ9KsUlRHCBFCRzSJGpdQnSk/X8mNYutwR5ZHCniKjmDgz+uBMC/NMWPItD01DXK0RK089AlfJwUWUMCDawP9v1CHcaFw0QN1xK+2kSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=gKqTSLWtH8cOsHdx/Qpk22308xu15xbIC/28EZ9CYoI=;
 b=cJKqBwxwyQMb/yhMJMA8qSD48YRbOj7+J/qERFqJWDjmzgwcFi+hWJWlaJV+HI3pdwaFo3Mn/KLrq+paGfqMIfAj/4pHD/+eUijo/lBSqAsNVXpz7isVgJCyk1SJ5cRG/PP0oORAItRSbuWrf/n7CCNlxICWSDV1vCS7yFzCzAo1pISVCUuSnPI6a2QytWsXk1/jmSL5oZdDKUcGivJO6L1dcZ/JhsXGgm+nemljbz+c01oSb8FM8rtQyCGU+seBbiCW8dwJI+RNj2o7EEzZyCVjd9K25GzBRSu1WYikkKzTQL0ZzkIhjm2jopPNBRlrFdzMdmD+lj0Q3gZD4gG3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKqTSLWtH8cOsHdx/Qpk22308xu15xbIC/28EZ9CYoI=;
 b=m9HiqXCAry2ScZabG0JZiuM2sH6pAQXy/LUJ4PTG8kQg41K8/nOLv32DwGDUErdCcsEodzbdXm+0XdLfx8Lf+fn8+ycCQC/jhVtvOC+vgaHVZ72aPjWShgGrTr1nU/CVq5nSCH/6967m0e+rA74vZx7mJVZLNvnFDkBNOG44DtY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR1201MB0092.namprd12.prod.outlook.com (2603:10b6:4:54::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.16; Fri, 17 Sep 2021 12:00:37 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d%7]) with mapi id 15.20.4500.016; Fri, 17 Sep 2021
 12:00:37 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix MMIO access page fault
To: amd-gfx@lists.freedesktop.org
References: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <9472de33-c1ba-e273-16e4-9c6d1764b0bd@amd.com>
Date: Fri, 17 Sep 2021 08:00:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::18) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YT3PR01CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 12:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3be5fc7b-4058-4bbc-a0fd-08d979d2c30d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0092:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0092549DA87C4AD67B271AFEE4DD9@DM5PR1201MB0092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsPdoLiIex6YkyBoYuptVXc34WZkSPg0grpeU4yC1PYVAUDTUFM9T9njVt17Pj+KIFvj0S2hpuqYonwCL1IeRX4FVVvFpTAk/TAmoH+n92TTmDEBhaZMK/HggAkp4HqYGXdVlK9L2VcCEvpxfC/zX1PORnO2kAuMGryl/+3yxChLq5QhqvLAt200zQqiS99FI7RMLdOiflLAllx68LywoJNnCZePyyJUfHM0f21kKf/KXb76WgAvHgupArs21ueQ+5L1Ukre4MPLsuHsUKpRx/M1Hfk5FJgR8SwRY6J7FnJMb5RL5Ex4JeC6wHVG8LfeLKsCc1j/g+cNNM3LQgoJf0E+Omk8Ch1MPUJAvnttodhVlwUA2sKw+864jm6/0fONQdlsCHgn9beAIRt3aOXTN7/hq9OiHWrO0b/ikqLjlYMXZyDhzcD4vCPJiAcQTi7lWDLiQjsd1g2VQ05NVD+nbFSdAb+e/lCzTrFZhk77SuNcGS6OZ9Y/Fa1LNu7eNTpvxeDTwjfCHQhDQIxkWsT79/PR0jB0QEHProSA4CGBuYMwqkU5uLhog6YE3HHvYH1s5ek7P+BTLvKOdNh5r+cQyz5WYKeScY+TXWqtJp+Qoc+loJ4iR7D5NCOVHyC/jFtcqjyRgV2jYjbkr+Cg/s2uH56/3LboDeWueH1kr1L99Kp41/kUqTd9AD3aIX5WZiUAyy9dCtV9bPYSky8bm39jQJPwUZHaDL2uMHSAIjmtc3HEC3rXOqtGZeD4ehW9jArJAmV7yXqanTtHFnbOjc4Dky93LkNONcLUw6vse1Xtcl6fXqpSS8rQDPaf4iJ8YrSkuDZlZh9FQPp3reNGroePOo5pZ5aPzDU+z/8KumOZ3aM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(478600001)(36916002)(6486002)(6916009)(31696002)(66476007)(66556008)(2906002)(52116002)(53546011)(83380400001)(36756003)(316002)(2616005)(26005)(16576012)(956004)(5660300002)(186003)(31686004)(38350700002)(38100700002)(8676002)(8936002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0l5QmFNcndoSWRkaVNpS3ZlQUFXQklKbzhVaDg2TjIxOTBLMTFZeThxOUZn?=
 =?utf-8?B?bkFOU0UxL3l5YWJFcVhIM0VVekNUTG1HVHZMaGc5dkFnbkx5bHA2dWxPclVl?=
 =?utf-8?B?bEoxTlIyYm4xQ3lmWktpSEJNNWh6YkN2LzE4a1RUdk5rUm9sQzBwcFFWS3Jr?=
 =?utf-8?B?bGtiZmlINENKQTVBc1dsd0JHWEVLOW5IL3ZSb1VSdkJRbEZCK3lKRnRUVi9u?=
 =?utf-8?B?Z0J4OGZpSDZROTFVdnFKdk1saXFsTmIxYzBRWjU1dUdDbWpyQ0lpNmVENHd0?=
 =?utf-8?B?WXByL2VPWlIzRVZaY3JqYitYZ2JzazV2T1FoOUVCR2lpR25nNWFYcVEvV2Y4?=
 =?utf-8?B?WEtoeDI4cXFWWk53QXdOb0VHOVpoaXdFVTVRVS9FRDBoWFhaRnNTYmJMTU5Q?=
 =?utf-8?B?SkNyR0FBVWpVM3UzSi9SRUQzRE0zaTN4MGdoYkVDRk5SalE3cG4zQnRrK0Ix?=
 =?utf-8?B?d213SmV6UWhralZLVjE0d3N1V3R6VEduQWtNVW0zNlE3MEI1MkNCQWN2dTVZ?=
 =?utf-8?B?aCt4cnk2QnFQZ3R6QmdmYW5pZzZkelVaQVNBT3N3Vkh3dTVuLzJlb3kycnhB?=
 =?utf-8?B?WEVEV0lyQnRJWXpLWkVFZEY0c2ZndmJNSzhnUjVtT3RjMkRYUUdiY0NDL01Q?=
 =?utf-8?B?dER5QUtKR0ZWeW95VTBzSnZzaEVteUpjb3J6VGRpQXhwaXl3SEswYUJXUUdi?=
 =?utf-8?B?cjVlMy94TkVSUVBZWVRWY3RtSTRXandsME14ZFZVSFEvZkNQRnBFKzFsczRE?=
 =?utf-8?B?SzdEOE5rSVRBcmFuditNQURGU3lSMnkyRUp2Uk9ET2pBVlNGVitnM2hQWmEw?=
 =?utf-8?B?UWRqTHJXOGR4Z1FNSTBTMzJEVlFSVk0xUjY5VVFyV05iVTZMNUYvRjdkTFhn?=
 =?utf-8?B?enlWR1lEbFJVUnFWUVQwZllZcTByVVBLVjZaZzA5djIwY245eVBackhyeHMv?=
 =?utf-8?B?YXMvcVJqTXdldkJ6c2pvKytxRjZ0YkU3Umh6Z3IyenVuYnNCa2hIRVBiRHFS?=
 =?utf-8?B?bEdXYXY3WnFoMkJvTlg4c3BDUFovM3BCMHdPTFFSUFVibU8ram5SU3BWSjNH?=
 =?utf-8?B?cGRaSXcwalRoeE0yc0t0TEtvRFMyTlJRbTVCektlRCtqZkJNR09PY1NBbU9S?=
 =?utf-8?B?bm9iN0diR1pGWDRNVUp0MWFESkJGeEdMaitBWmR6bG84byswWC9LTThMdlVL?=
 =?utf-8?B?MzZEMm1LZnRJUnhNc0krOEViemExU0VkVE95YXo5VDJzVmpEZ1NOT1ZPME0z?=
 =?utf-8?B?MmoySW9Rd0tzODAzeFJsb0FBYUMrSllhVmIwakZYMVVnUElrY1VPaFNjNWlV?=
 =?utf-8?B?Tk9WdlFDclFYbFNtNVI3bUh2Umx0KzFIRWF6ZWdETHB2amhoQVl5ZnFxREdn?=
 =?utf-8?B?YUNBM3Q0UU9vb05yNWZJbTJ2aG9IamZEbi9oRVJPdTlHUlVOM0IvTENGWms2?=
 =?utf-8?B?SnIzTUpNL0hEWHNTVms4NEhtLzdTOEJZSkxIMld2Myt4N3NURVRoNmR6MFB4?=
 =?utf-8?B?aUlxcWllaUVObUFxUDRPR3dmYjRFZVdqZ21BR0tsbzVhU3h1M0MwWjA0b08y?=
 =?utf-8?B?aXpOc0dtTVQzRUMyY1JncGFwQUtjR3poZHlmK3ppMmk4VW02clpzdm5adi9I?=
 =?utf-8?B?ZUxUQ1FiV0NOczJBeVdLSzVsUGQ4V3dVbmptM1RUNWhMMVZWWTZST0J6c3d0?=
 =?utf-8?B?L0gxa0F6QkY3V0ErVGlGcWREcHNBekxrZit6aldiQndlQVd1Y05MQXZFenA2?=
 =?utf-8?Q?TmrvSuIeT1SG4dFc295x3bow/4aGjgXQxlwpbDZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be5fc7b-4058-4bbc-a0fd-08d979d2c30d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 12:00:37.3758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kv6I/seIWAcjRwa/I0RCMO/na5lhLSCiNUaALA6qG4LPlCdSQuMiNvqNIzzZB6DL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0092
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

Hi Andrey

Can you apply this improvement  on vcn_v3_0_sw_init also?

With this adding, This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>

Thanks & Best Regards!

James

On 2021-09-17 7:30 a.m., Andrey Grodzovsky wrote:
> Add more guards to MMIO access post device
> unbind/unplug
>
> Bug:https://bugs.archlinux.org/task/72092?project=1&order=dateopened&sort=desc&pagenum=1
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c |  8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 17 +++++++++++------
>   2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e6e9ef50719e..a03c0fc8338f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include <linux/firmware.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vcn.h"
> @@ -194,11 +195,14 @@ static int vcn_v2_0_sw_init(void *handle)
>    */
>   static int vcn_v2_0_sw_fini(void *handle)
>   {
> -	int r;
> +	int r, idx;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
>   
> -	fw_shared->present_flag_0 = 0;
> +	if (drm_dev_enter(&adev->ddev, &idx)) {
> +		fw_shared->present_flag_0 = 0;
> +		drm_dev_exit(idx);
> +	}
>   
>   	amdgpu_virt_free_mm_table(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 2e6b7913bf6c..1780ad1eacd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include <linux/firmware.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vcn.h"
> @@ -235,17 +236,21 @@ static int vcn_v2_5_sw_init(void *handle)
>    */
>   static int vcn_v2_5_sw_fini(void *handle)
>   {
> -	int i, r;
> +	int i, r, idx;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	volatile struct amdgpu_fw_shared *fw_shared;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> -		fw_shared->present_flag_0 = 0;
> +	if (drm_dev_enter(&adev->ddev, &idx)) {
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
> +			fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> +			fw_shared->present_flag_0 = 0;
> +		}
> +		drm_dev_exit(idx);
>   	}
>   
> +
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
