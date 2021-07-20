Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FFEC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 20:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680F060FF3
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 20:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680F060FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB4E6E52D;
	Tue, 20 Jul 2021 20:52:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2A56E52D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 20:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsJDGHMbeunwXtFBb3S+ycjSQCd6tnJn+Aq3lmvnBq0bV+jc0GIlMtmz/OKmUbytf2mAz87W5OXIhzZjHYzJa1osTRZNPsanXjFql3d5c+6pv3dgo+eTcwEycxTtoOZXat51eloPyjPfc84HPca/xhY/XlGBjcZtlfu00X4fJjLSs7OEGmOmj3nh7UDaNgksvNp1FfebwK0zhufgTiXjAc7BJI2+ATeVbwckiMxh82rwM/BqPx8jdstyogzgMyYQUGA5eiydM/mINzz9byDPUPHiHbEbC8AlniNI/vN5QHpItQllSX5s7QgPWgtQtMeuS4soooGw/CWqFYc0Xs+LVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJvtQPqDS2I3DVc5d7dCNoiejB7BwdHlUYSn4qJjiQk=;
 b=gBoexYp+y7ctjUTsjM1dhw//wS/DsQaVaL/Sx0fAkALsQ+qZW0hkdoFrKpgSXLOQ1poIDin7IJ7RUUQ0yBYgY43iU9bZTwoLuSRTunzTVAGVwnI9uHfEOQKCkjktvp0JsiumOQSbQdVwe2ppGATeVTJYmnwUy1q0U2DLimGFQCNcgm9lfD1Hj+OzjcAmALy0Fj43Fm6AUXRUv4bQCFecmI0XTZOFTWMV03Fj60gRVJreo1xte5g1QnqlXnFAT16crdntnp3ve9B8BSHRTiNPw1IeY91DY5aswg0qBNpDaBrFUzNvPp+ThRnTF+fvQnuiNePivafZjIk8OpK3xx+Btw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJvtQPqDS2I3DVc5d7dCNoiejB7BwdHlUYSn4qJjiQk=;
 b=qv+4U78sd75p2x+pgOXVaKn08fzI6agDZngDVl9qBrgh7r6Rwrw9H0fEypR0LIndd1QXjRgoStpWHmuakhJ4EUOQbTJvMNKRppv9x/NuOwu3zntRThutMlBtTUjQdxCAbnedjOz8EfweGIYMyYfDocKosW2w/rrTVxA3GyWkYQM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 20:52:00 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19%5]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 20:52:00 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Update debugfs link_settings output
 link_rate field in hex
To: Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210720152546.654510-1-Anson.Jacob@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <573b3bdf-a388-d826-f035-1a163bb031d8@amd.com>
Date: Tue, 20 Jul 2021 16:51:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210720152546.654510-1-Anson.Jacob@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::13) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Tue, 20 Jul 2021 20:51:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274f26e6-ba49-4276-069e-08d94bc0382e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5459110D89754A3336C411DA8CE29@CO6PR12MB5459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEkyZC52GAg1yuejL5jVOhBcYHKF5PmojBOMIWLZCVj4VCnuPfJjV49b0xl15pCr1B9hf5fdAnMypjPt9nttmj8lbL4BJ4tx+S+4useVqZg4In/LrDelBq6aXsf34S6BVm3vhWREu1Sg8HeUrYGib2dWVfz0zB8zfJIKZFGS+thgq/rehIKPgL7S9HNWlm/5JZQWvsZ0evLWfpXzoUPHoKi05wrZT+n4R+rmicNdZHh9HMDi8EztwFbY4+6MVMncGNGaOlYaw5xF8WfxcSldseqwuNNi9TNcozaZhbjRuPaCSZRgzJ075k3Av4inF5BwVufx1kZ+w7SPIRKm/Ol2tYjTY/UIhaKS2cg4WLSRjQ3dF3z21VMjYIj9YVmpzIF3qcPpU9GagsPZQz6FJ+vpemS0UJbTCiotlmtEVEXauQnUXVz7s5yhQmfFPpEmOjDztCYHwDGRtC3F17Kxjc5fcNs3cSs2Ovrzrw7Yzztk+87nuQGYjorw5EjXOMhBDPDap4Nf4zG6MgATAFp1+Fg1aJoD8oKBXqcz0MbrQaGh3tOxolR4aiEnMdiy5sbXx/EhsJ8W4kCHYGGunHMwoXPIla173LvemgDzHxnwipB5KsHQUeaMmDCjIoBdsenhzyX/qXjgJK+0ypvcdKK7l8i2a+03fp/5A6FCXQ1Jsvq7Sc7Fq8fKA+lUpIEkN1AozqjuLZ4tv3a8RCQ0cwEZnr3iB+l5+ZJrHzWHRWGcAHY2sZLFam6/JmUaR6lXvmDj2fxl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(186003)(316002)(66946007)(31696002)(44832011)(5660300002)(8936002)(956004)(31686004)(15650500001)(16576012)(8676002)(38100700002)(6486002)(26005)(86362001)(53546011)(83380400001)(478600001)(66556008)(2906002)(66476007)(4326008)(36756003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdERHY2dzVWNDBTYlIzV29kN1hOQTJHSDdibjZzdEZiUEkxR2FDMERKNVF3?=
 =?utf-8?B?eHJEbE0yeVZpdHNweVdtanRTaEpQKy8xSnlpbW5nbmJ1ZzlUMkl6WnNXaFk5?=
 =?utf-8?B?b2licGM0dXN2YTJXa0NtUnlib1BkUXkvN0VjQko5ZHEzTWMrN3k1dUNuVENZ?=
 =?utf-8?B?RVRpczRxT24zcTBab28wY0FUZXNWNkZ4RlBCeVl1UUFRdzByMjRVZkVLNElo?=
 =?utf-8?B?UUExSWF1VVlaSm1tYVdwbzZDU0RpdW0vdVB1dVhpSXFRTXI4SFVyTnkrYlRC?=
 =?utf-8?B?bHN6ZWFZV0JSNzByeWRHeWhoZEFldGJEUU05bVE3Q2pkaU9tTHhWajJLamZS?=
 =?utf-8?B?QmJobEt0UGFpYmxaeloxTjZYcnVCQWE1aU42ajZ0M1JPZ2ZPSndjc1VQMkpX?=
 =?utf-8?B?Z29xbEh4RklEZTVxeCthaE9kUWM5QVRzWXlJYjdsZmlMZnVrbC9lU3hNU2ZO?=
 =?utf-8?B?eGdRczJZc3BDVVUxN0ZPbWlqclI1eTVuMjJSZllXZ010Z2Q1amVmUmE5TkJT?=
 =?utf-8?B?VDZ4dWNRdDdBNDIrUVg5OUFibkZaK3NsK25EN2lzK3dHK21mQnFBaE1GM1Za?=
 =?utf-8?B?Sm0vczEzSHgwZW5pOWwzblBlNVMzUnpHMFUzZytJMHdVc2J2NDk4aU03TStx?=
 =?utf-8?B?cU5xM2FTTVZ0ZndiNTc5S3BVamlXSzc1MFR3Vkl3THh3bWhYTEVsd1ppd3lY?=
 =?utf-8?B?QnA4c2pFUFIwelYzaFZJbkROSllZNEdSQ0pIRStmd3czcUszdUN3T1E0OFo5?=
 =?utf-8?B?V3k5anEwbWowaVFiYUU4RnR4YzEzdlhvbWJoV1pqZ0Q4L01QWkx3czh4RWJs?=
 =?utf-8?B?Q1VQSjdhOHJSYWUwT1pPK2V6eG1VNE0wMHVvTm1VT0dFSURJUE1IUEF6bmFM?=
 =?utf-8?B?WFVMWFBIcGlrVXE3bm5YWTZhNGhCMlplaThpVnRQS2x0c3U0NEl5OTBEeFUy?=
 =?utf-8?B?bEZVbWl0bVkxbzFmT3ZvVlRwSE4yRmhqY2Q2N1lXcmRZbkRMUUpWeUhVTUtt?=
 =?utf-8?B?RUF2UTI1UUlaRkg0Q3lvS0xmaU5CMzJ1Y2VtZC9FeGN3UHZQbVlpdWhBbFBV?=
 =?utf-8?B?aUhKNWtNbjFWVGhqZ1VUNkdEMkZwaWQrSmE0SUZZd3dnSkNoOHQ0S3hGaXVG?=
 =?utf-8?B?OHBTLzI2bVFJVSs3bWo1SXJFb1liYXZmTHRaUS90QS96UisvTXE1d3B0QnI2?=
 =?utf-8?B?UVFNZ3pCRVZOd04xOUVYVDNhc3E2bHRGRmJlSlVKZC8zelBTWEpDdFZZY0JZ?=
 =?utf-8?B?Wi9TbCtmWittazlaZUFUb1E5WXRid2hMQWk0TTA5MkFlS2xSeGNuVWIxK05n?=
 =?utf-8?B?R2N4ZTN1UnVienV2TDdNQjdyK1RJVHJRWnR5bzBYam1pUVpxWTV6OVVZUXNq?=
 =?utf-8?B?S3dFdGorc1MzcFhIaU9CRUF0Qnl5RmE2TERjU2ZIRGZFZlZHZTB1OC9uWXhT?=
 =?utf-8?B?dElFSUtWaVBTUGhBMkp1QXdYZ2Y3STdXYWdqemsrRHg5RVphbnI4WEc2ZlVa?=
 =?utf-8?B?QVdrOXJaUjF1cWxFTVowa1ZUeWkvWFpXWk9ZaEw4MkpBOXJaWEVEdExqbVdt?=
 =?utf-8?B?ZUJJcTZHUG9VczZySCtvTk50YklVYmVEbWl2MHRwYkVZbTQrQnIzNjhyRXps?=
 =?utf-8?B?R0kzVEx2OEIrTmQ1Y1V2OHZMK1lwbVRWZGFEODlDM3NodGlES2tzQkFkcFZL?=
 =?utf-8?B?KzNtQUhmYnlMamMrT0ZLNXBsczliSGM2aDBRRHRMU3d2eU1HN00wdWhUcUJL?=
 =?utf-8?Q?k9LEZusKi8s8jOjF+z3hScmpiiGUKJNy8Bgi7BS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274f26e6-ba49-4276-069e-08d94bc0382e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 20:51:59.9249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZokJPGoqsp99lW846hJvka0UxwFA33Eonabui2LSi+aTPF3BPgDB52+kAiL+jcwp1aSdPk4Eyd3+XfQiLBBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
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
Cc: stylon.wang@amd.com, sunpeng.li@amd.com, nirmoy.das@amd.com,
 Nicholas.Kazlauskas@amd.com, aurabindo.pillai@amd.com, hersenxs.wu@amd.com,
 Wayne.Lin@amd.com, mikita.lipski@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-07-20 11:25 a.m., Anson Jacob wrote:
> link_rate is updated via debugfs using hex values, set it to output
> in hex as well.
> 
> eg: Resolution: 1920x1080@144Hz
> cat /sys/kernel/debug/dri/0/DP-1/link_settings
> Current:  4  0x14  0  Verified:  4  0x1e  0  Reported:  4  0x1e  16  Preferred:  0  0x0  0
> 
> echo "4 0x1e" > /sys/kernel/debug/dri/0/DP-1/link_settings
> 
> cat /sys/kernel/debug/dri/0/DP-1/link_settings
> Current:  4  0x1e  0  Verified:  4  0x1e  0  Reported:  4  0x1e  16  Preferred:  4  0x1e  0
> 
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>

It probably makes sense to use hex for link_spread as well.

Either way
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index f1145086a468..1d15a9af9956 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -197,29 +197,29 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
>  
>  	rd_buf_ptr = rd_buf;
>  
> -	str_len = strlen("Current:  %d  %d  %d  ");
> -	snprintf(rd_buf_ptr, str_len, "Current:  %d  %d  %d  ",
> +	str_len = strlen("Current:  %d  0x%x  %d  ");
> +	snprintf(rd_buf_ptr, str_len, "Current:  %d  0x%x  %d  ",
>  			link->cur_link_settings.lane_count,
>  			link->cur_link_settings.link_rate,
>  			link->cur_link_settings.link_spread);
>  	rd_buf_ptr += str_len;
>  
> -	str_len = strlen("Verified:  %d  %d  %d  ");
> -	snprintf(rd_buf_ptr, str_len, "Verified:  %d  %d  %d  ",
> +	str_len = strlen("Verified:  %d  0x%x  %d  ");
> +	snprintf(rd_buf_ptr, str_len, "Verified:  %d  0x%x  %d  ",
>  			link->verified_link_cap.lane_count,
>  			link->verified_link_cap.link_rate,
>  			link->verified_link_cap.link_spread);
>  	rd_buf_ptr += str_len;
>  
> -	str_len = strlen("Reported:  %d  %d  %d  ");
> -	snprintf(rd_buf_ptr, str_len, "Reported:  %d  %d  %d  ",
> +	str_len = strlen("Reported:  %d  0x%x  %d  ");
> +	snprintf(rd_buf_ptr, str_len, "Reported:  %d  0x%x  %d  ",
>  			link->reported_link_cap.lane_count,
>  			link->reported_link_cap.link_rate,
>  			link->reported_link_cap.link_spread);
>  	rd_buf_ptr += str_len;
>  
> -	str_len = strlen("Preferred:  %d  %d  %d  ");
> -	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  %d  %d\n",
> +	str_len = strlen("Preferred:  %d  0x%x  %d  ");
> +	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  0x%x  %d\n",
>  			link->preferred_link_setting.lane_count,
>  			link->preferred_link_setting.link_rate,
>  			link->preferred_link_setting.link_spread);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
