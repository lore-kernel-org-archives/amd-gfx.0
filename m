Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A285C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 14:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AFC61468
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 14:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AFC61468
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9791E6E9EC;
	Wed, 30 Jun 2021 14:25:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0766E9EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 14:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsTIRC3oXtwbaaJSdzG8tz961EAbuiWHvPwnWKO/h9Np2TiMTS97RiAOzwgjKItebCrXwEawRiOY9V4uppVF6uaX4rL1wRUiXDsZf8lRbx5r4A/mHeTM3drP55x+R7jT3bEOV0YptYW8nk1Mud05PEwSIL36p9oAc4RvlH9KL1E336eMixLJNsPNUQWnykds3jDTE+Fg/b9V8AMG+5xsaihy8oxzuy3PdLWXSh9RIpqblcf2SXEZloDEbElHez4B9jO+WLPJJ5nb28OJnhfM0PCBE53QdO5lfqelqNtqumPo7SL+WtT+y0DgTrjZyxvPs+cgaARGHLlVpX3PqulCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIrvjO/hgSmZ0OQenLBL57Lm92DQ6BqWDGgvnGc0vjs=;
 b=b2uIzGRAEP3lbgS24O9QeroTrZnidePAJQrT8e9D8wCQoNVFTv8+VSYp3hgNcgsfmbkP3C2/sSHa8hyY4w6tzEKwplv3kVc/YsglzPoKU2IYZ5oXvEv55g9LIzi8uPqv1tyPCfwhqqBiKfufM8UB+EpHwjGEMj7H9uJneiguKaJ25FmQv41g7iGLAQnnz7twv+8vucyR0xTNhArKtvuigPOo0KwFsX4gVl8PE//Mo0K6hUZasopimwPSEMKiriMXeQhJE/oMGKdCkqZ83VifBXtS6T3dpcNKP2lbOMi9sgzJgCFgbaRxAz43J+Xw/8qcC4EAYibt9hioZ9DBHuk/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIrvjO/hgSmZ0OQenLBL57Lm92DQ6BqWDGgvnGc0vjs=;
 b=nMzBmsDnnDl9FblnxAL9E1gZyEdfMQIsg8AT2AN+yLuGDJskZ4v96LoEnYPE0VkAqKTgNfoeXFdoszvM7N6GHZpLynod9y0/+/MLjuB4jzKFa3wRecQ9HzML2Nyg9DGndJ66P6pW5jI8oQbmlGT/qz4ZSKRDCzAOzz71duFDPto=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 14:25:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b%3]) with mapi id 15.20.4264.019; Wed, 30 Jun 2021
 14:25:05 +0000
Subject: Re: [PATCH] drm/amd/display: Extend DMUB diagnostic logging to DCN3.1
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210630140729.28464-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <297ea046-f207-e341-e150-f3fac814e1f0@amd.com>
Date: Wed, 30 Jun 2021 10:25:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630140729.28464-1-nicholas.kazlauskas@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: QB1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 QB1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.21 via Frontend Transport; Wed, 30 Jun 2021 14:25:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e63be863-d0c6-4775-be10-08d93bd2db03
X-MS-TrafficTypeDiagnostic: CO6PR12MB5395:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5395EE8A0DEFB30471486A638C019@CO6PR12MB5395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcqRkDSD9NCciHDdkLQkKT6dGyc01v1q0/6gLZX3Ig3D9hSfIWwbG9Z/4WX6KeiU+0JI1Bsx4M5oGre6qefqDozTYwFnZKIMNdofqacLhZTicGcsQZMBbtmogwca/9ISfFUEc6Sy/nEgPSw3Ik0oP9+puqC01xUjy8VA0zRF1QFDzmOdc3hwo6SG3s20ujn+JWejmPnG3pxdesve2AVvMtALjPivs7QwA2q53yp547EyQRnHniiCzSFWgCMUaH9Z2IdwbF4U4a5fJUCgG4anZwMqyZhmKpKYmxEgJJIQnepCGnjT7XuSPadyQm1kcx5xl+x9i/cJ06cw7KGxv6DkkRBAQhtVamCBOYDq7gvkRowB1R5F/7p0uBdtte/hbTdNK4P00hdRv3NkqpjplNurqDU7WgEdDDBdhEhNVqC9UcYe76+6Nz/IpM6vkSLoJmV/oJLagqjm2FDFeP6adBCvTDY9/yEBTBWmCY8lbX5FR8B5fqLldd/G6jph3PChIXvcGvLfe20vHgiqK/gpIx+LGBR662wqEHTMdsDu8g8SKhdTHpPT8boEZY9CWPFo1TMCeLb88avpSEWlrsMmMpPM4nF31YUmea17OwuWcAQRThAuuIUfEXhzp2NubaRjCFJAX23fMeJGBE6SmjcIBI4+vu25YfHmCj57bVexmkgfk0rVEdHGkYIXtD53opqtVCFhvEiCAp1spbYC1eGUDDQ7NWqoZsZis58lcUNy3Q2E78phC+W9+B4auNt2Id0zQohV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(66556008)(66946007)(66476007)(8676002)(86362001)(31686004)(478600001)(6666004)(44832011)(2616005)(31696002)(36756003)(38100700002)(956004)(2906002)(26005)(5660300002)(83380400001)(16576012)(6486002)(8936002)(16526019)(316002)(186003)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThxbW9lRHBLSzNGWVZYOGg5dFZaaE0vcEtObEo4NVJURHRteFNCRm5VLzNV?=
 =?utf-8?B?Umh2VGx5UXduRVkxaSs2VFN4aUlXa0JIMXRyVG1pQUNOaCtWWU41MTdsbTk4?=
 =?utf-8?B?NUdVUDJlQlVhUnh2aGJNbUEwRXFmeDNzbWQrVXlaSkc5ZHBlMkk4aTNkWTQz?=
 =?utf-8?B?R3laSWthTU03dnBITHoza2Vkc0tsRUU5L0hHRnBhRGlJdDMraXpqVmJabHJl?=
 =?utf-8?B?VzBTUUJvN1FXbkdSV0NCc1lmRGY3d3E2c2QyYnNVd2N5OWVCTzBZZHU5Y2lk?=
 =?utf-8?B?VTQ5ODVSQnp5RG1rVVVWV1BhdG1ESXZPZVhlUlAxUmN4bmZWQ1ZsYUxka0pO?=
 =?utf-8?B?SHhKY1FOYWFGOFRWelMrT2UxSytLYWFuQmJxU2lZeXU5bmYwOFlMOWN0aTB5?=
 =?utf-8?B?a2thb0RHencvQTVqbmZueStRUjY0QktyRngzNWxJeGRGTEE5UlRJNTNtckM3?=
 =?utf-8?B?UXJrdTVaeU5ULzRDendGbWtjTDhPeVNTdkR5TU9BOWovaURtaG5XZnA1K09a?=
 =?utf-8?B?S2JKWkFDTnM3S2FCWVgycFdhSWUrcmtxZE5PSmY4ak0wMENxQmNNN1JpOWw4?=
 =?utf-8?B?QkVLN2xaeHRueU5kVU5JSm4rcFFxY25PUklkY1VTQ2haSEFFSEEzODdkU1JN?=
 =?utf-8?B?dUhYQ2gvSmpxczkySzlncXJFdFh6QUxFUjRicnZ1U2M2M2pwOEtOUUtlWG9D?=
 =?utf-8?B?YXVpWlhKa3d5MHh1RzNnb0NvSm9uYnpyakVKZ0hWOXgyQTEybmM1eEIydC9E?=
 =?utf-8?B?b1VSWGY4Q2dwdnIxTVNZa3BwdisvaFFTMEhxL1d5UVNVS0VUcXI4NzZMdzhw?=
 =?utf-8?B?Q1dtM0lqNFFsSDl3Q0xkZUY2bjRTQWhuWjQ2ZTdKTXFlOUdCVmFwM2lhblZ6?=
 =?utf-8?B?QXBMZHlTdGswT29odTJqVFFiakZuTjlvcnhqVFdrVkNUQlF5V25EcDJvWjg1?=
 =?utf-8?B?ZWY4T3ZBZThWUzFzT2M2QlBmelI3cEorU01UNGgwZTBYalJSQW12N0tLVHVo?=
 =?utf-8?B?YkdsQ0NLYTFRbzVTNldkZmo2NWhvZjlXZjU4blNhZ1BFZGdxakQvQU5pODU5?=
 =?utf-8?B?aFVidDBvNlZzZ1hqU1ZmV2kzWk54L09TV21HV0lLbUFqeCtrTFh0MEdSbTZX?=
 =?utf-8?B?Q3Q2SWVhRmdzR3Z3b2pzWnJ6MjN5NWUwS00vQnNBUTJFTDd4eE9TS3lLanRx?=
 =?utf-8?B?UkhsUHNvV3RWb1BDUC9ES0xDMlZJWXpRSlVUUmF4bnZQMjN4aTVYVUNEOXd3?=
 =?utf-8?B?bkNOeWNsVEhZaEIrVmpmaVloS1JrYmZ3UXNpWlZQNDk4NXY4bGpNT0xRcGJl?=
 =?utf-8?B?RkZNdDU3aWlHQzRpbHNTYkFjQ21zd1FyYXQ5cFprNkN2L1RrUWNmYzFqa1hG?=
 =?utf-8?B?bzB3TGpKWldoUTg1L0pRdlBwWlBQY1FDNm5nWnV4NXE1eGFyMFB2akFqd0tC?=
 =?utf-8?B?RWhGcU1aOVpMSVBiL3VROVNYMGRESUxWeFBqb1BHQVh2d2treVRJUmdMdnlS?=
 =?utf-8?B?Ujdnd2JsYVVmd0h2eVlUTzB2ZDNseWhIUWN5d25tdk9GRU1VMDVRWFlNY1Jv?=
 =?utf-8?B?V1g0TWg5TkNuc1U0aUVCU05CMk0wTC8rYnpjcnZTZnhmcmZEUll2VGJybGs3?=
 =?utf-8?B?ZmlUOEtiUWM5ZXN3Mnhwdm1WL1JBUGEwckw1U3dVS3VuM24wSkpJcCszVGQx?=
 =?utf-8?B?WnA3Rm1lVUlPTExvT1A5c1lvaU9uR0FkTDczK2twYnI2bCt3N05HdkVXdmln?=
 =?utf-8?Q?+BQ1QpD7t1ZRCCfeFQ5rRugtxV3kVKrRADgss0R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63be863-d0c6-4775-be10-08d93bd2db03
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:25:05.4526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhlD5iGALdhVhM2yniONub5We0pnIOqWM5q3rYuU6mCbCpwEX4x2S9Ik26YoOfSkQVIRvsyvTJPmCkfuwkJxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-30 10:07 a.m., Nicholas Kazlauskas wrote:
> [Why & How]
> Extend existing support for DCN2.1 DMUB diagnostic logging to
> DCN3.1 so we can collect useful information if the DMUB hangs.
> 
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 60 +++++++++++++++++++
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h | 16 ++++-
>  .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  5 +-
>  3 files changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> index 8c886ece71..973de34641 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> @@ -352,3 +352,63 @@ uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub)
>  {
>  	return REG_READ(DMCUB_TIMER_CURRENT);
>  }
> +
> +void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
> +{
> +	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
> +	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
> +
> +	if (!dmub || !diag_data)
> +		return;
> +
> +	memset(diag_data, 0, sizeof(*diag_data));
> +
> +	diag_data->dmcub_version = dmub->fw_version;
> +
> +	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
> +	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
> +	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
> +	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
> +	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
> +	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
> +	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
> +	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
> +	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
> +	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
> +	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
> +	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
> +	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
> +	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
> +	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
> +	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
> +
> +	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
> +	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
> +	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
> +
> +	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
> +	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
> +	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
> +
> +	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
> +	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
> +	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
> +
> +	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
> +	diag_data->is_dmcub_enabled = is_dmub_enabled;
> +
> +	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
> +	diag_data->is_dmcub_soft_reset = is_soft_reset;
> +
> +	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
> +	diag_data->is_dmcub_secure_reset = is_sec_reset;
> +
> +	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
> +	diag_data->is_traceport_en  = is_traceport_enabled;
> +
> +	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
> +	diag_data->is_cw0_enabled = is_cw0_enabled;
> +
> +	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
> +	diag_data->is_cw6_enabled = is_cw6_enabled;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> index 2829c3e9a3..9456a6a2d5 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> @@ -36,6 +36,9 @@ struct dmub_srv;
>  	DMUB_SR(DMCUB_CNTL) \
>  	DMUB_SR(DMCUB_CNTL2) \
>  	DMUB_SR(DMCUB_SEC_CNTL) \
> +	DMUB_SR(DMCUB_INBOX0_SIZE) \
> +	DMUB_SR(DMCUB_INBOX0_RPTR) \
> +	DMUB_SR(DMCUB_INBOX0_WPTR) \
>  	DMUB_SR(DMCUB_INBOX1_BASE_ADDRESS) \
>  	DMUB_SR(DMCUB_INBOX1_SIZE) \
>  	DMUB_SR(DMCUB_INBOX1_RPTR) \
> @@ -103,11 +106,15 @@ struct dmub_srv;
>  	DMUB_SR(DMCUB_SCRATCH14) \
>  	DMUB_SR(DMCUB_SCRATCH15) \
>  	DMUB_SR(DMCUB_GPINT_DATAIN1) \
> +	DMUB_SR(DMCUB_GPINT_DATAOUT) \
>  	DMUB_SR(CC_DC_PIPE_DIS) \
>  	DMUB_SR(MMHUBBUB_SOFT_RESET) \
>  	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
>  	DMUB_SR(DCN_VM_FB_OFFSET) \
> -	DMUB_SR(DMCUB_TIMER_CURRENT)
> +	DMUB_SR(DMCUB_TIMER_CURRENT) \
> +	DMUB_SR(DMCUB_INST_FETCH_FAULT_ADDR) \
> +	DMUB_SR(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR) \
> +	DMUB_SR(DMCUB_DATA_WRITE_FAULT_ADDR)
>  
>  #define DMUB_DCN31_FIELDS() \
>  	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
> @@ -115,6 +122,7 @@ struct dmub_srv;
>  	DMUB_SF(DMCUB_CNTL2, DMCUB_SOFT_RESET) \
>  	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET) \
>  	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_MEM_UNIT_ID) \
> +	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS) \
>  	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_TOP_ADDRESS) \
>  	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE) \
>  	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_TOP_ADDRESS) \
> @@ -138,11 +146,13 @@ struct dmub_srv;
>  	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
>  	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
>  	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
> -	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET)
> +	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET) \
> +	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR)
>  
>  struct dmub_srv_dcn31_reg_offset {
>  #define DMUB_SR(reg) uint32_t reg;
>  	DMUB_DCN31_REGS()
> +	DMCUB_INTERNAL_REGS()
>  #undef DMUB_SR
>  };
>  
> @@ -227,4 +237,6 @@ void dmub_dcn31_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
>  
>  uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub);
>  
> +void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
> +
>  #endif /* _DMUB_DCN31_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index a195734b4d..e58740afdc 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -211,6 +211,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
>  #ifdef CONFIG_DRM_AMD_DC_DCN3_1
>  
>  	case DMUB_ASIC_DCN31:
> +		dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
>  		funcs->reset = dmub_dcn31_reset;
>  		funcs->reset_release = dmub_dcn31_reset_release;
>  		funcs->backdoor_load = dmub_dcn31_backdoor_load;
> @@ -234,9 +235,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
>  		funcs->get_outbox0_wptr = dmub_dcn31_get_outbox0_wptr;
>  		funcs->set_outbox0_rptr = dmub_dcn31_set_outbox0_rptr;
>  
> -		if (asic == DMUB_ASIC_DCN31) {
> -			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
> -		}
> +		funcs->get_diagnostic_data = dmub_dcn31_get_diagnostic_data;
>  
>  		funcs->get_current_time = dmub_dcn31_get_current_time;
>  
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
