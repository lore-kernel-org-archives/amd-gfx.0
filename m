Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB12DC83001
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 14:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991BF206C0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 14:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U2ygRWpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991BF206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6160D6E443;
	Tue, 28 Apr 2020 14:04:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FA66E443
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 14:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESc3QcjMXUodrq9axZOM8JQaT+K2PGPT10kH72asU+Dt6rfS3aC5NMPrZhdk0s1Wk41tBDlLgqLkDX88zfdJB4KvCNQ924e/i10ZdQlQviItdGlG0DrhCZf31l6Q4ITlyZUIulMETTCrorM3MY0E+wOanaa17qwUsWg2Fb7CRtmH2/3hfVQ2l1hq1IH5Wf+qm/U26Wvd8V0E1XbBS021T/ud5yrNOhofbCL1UayG9aEg3CqcgtG72zHl8w7zBeiuIDF2QkSJ1DqUjPYBVSdjkpQl44sfpJC24t9q6uRDiIIS8S5OsvgRT0+cJbc+ICnh7H+tLIhMzzZN4UKu10cZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzHHqOxCgmPIw2a/sgV6s6LAMoxuS6NfvezsF/W/IBs=;
 b=bknZVdiRjsFbmXUrPB9b3jLwSa9qNBfgJnMCJ6Cm2Q0uPLCzPNZWhAVvFQt1sFXv6S+/A5Dr5MsCCo/h/gB6r8CU8hiiZeeeijRoUGTN5OjCQO3jJJtC7V4vX4P7NwFCp1lZnid2tDfcF9UIWh3nasiZb3Ka3y6xjP6cPLueOIybAmAs4Zlq5rZ4kVUWGsQp5PRA8sZWAK2ZyddTZMaAdfcqpgG3ffwWemBlFlubRJJs/c2fc78E1jHQIdEfZNwTPx7672l5xAyXnnsZ+klXywBw2/vk7TGQwLcYJDoAGjDRG6NYKbRJFa/ck7zlP0KpaXUw1wOZ2ZLf0XfbL7EJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzHHqOxCgmPIw2a/sgV6s6LAMoxuS6NfvezsF/W/IBs=;
 b=U2ygRWplqhP0UupeCFHTVxVS13iUTf3Hwr6RgYuqk002F+P0USkAe81nC6P6HWn9A8QM0SEXQpl33JQP79HooYjbu22m7GqbNYR5rfZj0mWGSQrTJQSvPeAcEjkH70KUtmPX16gSeklsxBvPoJwXicSLKK/dH8HvJMkJGIOICzw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1402.namprd12.prod.outlook.com (2603:10b6:3:73::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 14:04:18 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::3dfe:f611:26be:9121]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::3dfe:f611:26be:9121%8]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:04:18 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn2.5: wait for tiles off after unpause
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1588017957-6910-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <8af10763-aec5-0924-56f6-0d1c938fb4c7@amd.com>
Date: Tue, 28 Apr 2020 10:04:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1588017957-6910-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::37) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:e2d5:5eff:fe20:5971]
 (2607:fea8:a200:445:e2d5:5eff:fe20:5971) by
 YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 28 Apr 2020 14:04:17 +0000
X-Originating-IP: [2607:fea8:a200:445:e2d5:5eff:fe20:5971]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 417a688d-6c5d-4ee5-57b1-08d7eb7d0aac
X-MS-TrafficTypeDiagnostic: DM5PR12MB1402:|DM5PR12MB1402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1402D4EA859987CE55D84594E5AC0@DM5PR12MB1402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(5660300002)(44832011)(31686004)(186003)(16526019)(8936002)(2616005)(81156014)(66476007)(36756003)(6666004)(8676002)(66556008)(316002)(66946007)(53546011)(52116002)(31696002)(6486002)(478600001)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1JVrqViJyM2N7Os67zkliPkZvB5Tx3UEoXN4X5IeSxvDSaNtsW/vMEtm1Lw48R8hD0bgGqhXzBIiDySch0oCf4jT54wzxEj0NzGkWkddrT40z5fhRJLk6CzPpWjNqC+5J9WAqW4hjJYFW72NSCyYxlZ1sPjL4zbOxt6Lzzl2bP4zUfAlqJF5ncU44QC/FJjL7JTRBAyNWxac255XVKih1w2EfJa3j/3UpRKn5PVA3VF2sMAtBEbMuz1vx3eqlaojUp0GTSx89Nqv+0HYZUoLJuiGDmPuhnceOjuqxQ3kjUPfzkEnhvb5C3wcf6WDk66Ml1WwkYdhB335kJwpbFh0vuBoPuRwnQAdcsOE0IoMQWLK3oSDBMHLdhAWljwK779bC8e/6lxraLLoYEvm4Rzs3k6wG8i1wiNpTNV2U18htgPp2PrqbjsSr+NVDmtbcar
X-MS-Exchange-AntiSpam-MessageData: x9JGFxJBaJlGQuqq3H5Vp58jsuvv0IyEolFS0+TJSM+AeMX4wcxNLIxgJNYMQrCisKXSbfdriSah7BNOzaS/OzVWN6dfXck5NvqfPTYkXuhru3KAcZNlq4yPrZntZjBcpF4TMYqvKUVqCJoXRdKDfhrkHDgGIksWBIGHppe0nYdRijhpSS1eD1rs4BUrULsPYH62bN15zdbEKcR/WPCvgLOtsZOssG05sNp/1HYdN59GrVSamXD+OHzx2bjf51Ni02+EQue5bHXQEpyMmAafAEfNSyh0T+5w6quPwBVsfu5ZeTmbdo4f5wTEaj3GYZiLjug39b6LeU3WWLh6WdJfjWp/dde2pOgDj7MzZft8njsN8SA0BTcMeoeJQLKJCe1hhwNfRRfOeuEPZCX/yJXjMNWwB8iYLg3PHnugfI//eoUTwMDCUloK0GdHmrY7mOSFqByXfk0GHcAaIbet7BeBkKyeJDO/cz8C9CZH/fTtyK1ZONHs/iV3BV9weuP+NAtyCM/Sk+/o1FgVJUz8842875vpKQP8pi5kHwQHTkv3I3eImsNGQ5WpLkXmWpj939DetoQlzogASH3mRuabrDtTLDgLpQ6wfwto1odTw+25bcubvF0ThLiSa6ZVMIFkDeULxBIMGd2aJUyfxGWkpAM5DfyBzz5Ns7fnr5qHaGU8BuYUwEkEMHRh3qqMUEh0axYkD4a3x/tk5S2oIp4pvDfKYrka16gFtF+dqAozSB2PkbJdur2A/JluDLvNUzm0/deJd9tfPjBrvHA8ya20ge0aXUKC8xet2Z99Y8meVhv9LZ6L1UTbW/4LBgctp3v0ZoksGKojHm+HIz6GkYNGLI0CDnnDhoi8lbDsQjlCHJ9Tjsg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417a688d-6c5d-4ee5-57b1-08d7eb7d0aac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 14:04:18.3768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUb52O29dzG9+J5TCCWdjtaV+cSfZaFn2HRjSg+ZO+61+UkYD/TI4Svs6IgDfvgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1402
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2020-04-27 4:05 p.m., James Zhu wrote:
> Wait for tiles off after unpause to fix transcode timeout issue.
> It is a work around.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 0fa1c5c..38ca4a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1404,7 +1404,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ring *ring;
>   	uint32_t reg_data = 0;
> -	int ret_code;
> +	int ret_code = 0;
>   
>   	/* pause/unpause if state is changed */
>   	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
> @@ -1414,7 +1414,6 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
>   
>   		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
> -			ret_code = 0;
>   			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
>   				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
>   
> @@ -1469,9 +1468,10 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
>   			}
>   		} else {
> -			/* unpause dpg, no need to wait */
>   			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
>   			WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
> +			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
>   		}
>   		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
>   	}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
