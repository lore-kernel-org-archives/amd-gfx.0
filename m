Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37494C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0E024656
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hjaaI72m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0E024656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3C16E821;
	Wed, 19 Feb 2020 15:52:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811AD6E821
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMEYom5OmSjOF8Xc7JhNrERuSpHTTxrnnt0QY9Y4Puf/4U0WmCoTLCPrXT4qN38EEHkq3O0dSrMq+52Ly+ZtQyaxA/ezQkFXpdid6BfeOE5O5ltwwHH9Wm8+iiWDCSiSBpH501ZuiAxxVVShDkNRrMOkSSiSSkirJep/AoZgHkvoip8It24htH4lb/D/OwdzLylCBda24mzFeH5FcBL6lExtx05ZwBHmh6FgKiNcSIxVnm7sMlfqVZHOYNYVEX9RCT7EAV968tP6AZQiHFQA2eem7BnEO/2FN38cjB3y86CPwPRFtn0ehdavxcjMQSICfROfwLslCEUbo6+LsHEbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz7ub224fi7F5t8K2W5ezI7v1GPKhZdJqFdLYE9Kv7k=;
 b=YyDjHw8OE6aAzf6FTw5u0NbaMDppVO4gHy5U7/KOT5P2MOKVepeA+TQkcsgK0h/J+iFASZgHCtI7cHLowKGVQH2SSUsDi0GlBNomy6If1MmAqQeqcae3RlUWIKvQHVwMf8obu2uTPZE+9tbw3NsZzyVGvl2FeesyomyEYT7GBJuSrTP6cGFwU8ZXI26HdrPMPJixUWmEtbg8RV2bG3N/40GsWrDn0ErqJMm5P8OFYK5ckYADA10FC+u1lZ23IjA0UU6rptjJ2jSVFVomAPgR6r4teaDri5pkSKUP/PhBRF2XAoTXop+8cJ2p/mHmXMPLEZmCaFShnRXHUYnoYPOhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz7ub224fi7F5t8K2W5ezI7v1GPKhZdJqFdLYE9Kv7k=;
 b=hjaaI72mxNEWN2UhHeCHRgBE5amh44hucp4fbFnU56F6SH/j2FJOP2z5aF7qoAptNILYKiZKbKWgSvejaE9gGr7eWSIQwUnJbUS/WBps4um2KZRyNtphCOmFTS5FLaGfg1fn9fg1zrxxbTGNualIOTinJ2YsVaB2NM9ZAZUj+bk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bhawanpreet.Lakha@amd.com; 
Received: from DM6PR12MB4236.namprd12.prod.outlook.com (10.141.184.142) by
 DM6PR12MB2732.namprd12.prod.outlook.com (20.176.116.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 19 Feb 2020 15:52:25 +0000
Received: from DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4]) by DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4%6]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 15:52:25 +0000
Subject: Re: [PATCH] drm/amdgpu/display: clean up hdcp workqueue handling
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200219142430.2109710-1-alexander.deucher@amd.com>
From: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>
Message-ID: <49e6aee2-ee94-1858-d37c-9418a2aab8bb@amd.com>
Date: Wed, 19 Feb 2020 10:52:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200219142430.2109710-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::18)
 To DM6PR12MB4236.namprd12.prod.outlook.com
 (2603:10b6:5:212::14)
MIME-Version: 1.0
Received: from [172.29.2.119] (165.204.55.250) by
 YT1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 15:52:24 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f7960a2-7668-486e-a4c9-08d7b553b6d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2732:|DM6PR12MB2732:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2732CC9472CBA615DDE596FDF9100@DM6PR12MB2732.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(52116002)(478600001)(8936002)(8676002)(81166006)(81156014)(2616005)(956004)(36756003)(316002)(16576012)(966005)(45080400002)(53546011)(6486002)(66476007)(66556008)(31696002)(5660300002)(86362001)(2906002)(26005)(31686004)(4326008)(16526019)(66946007)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2732;
 H:DM6PR12MB4236.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AN1IlW0ALhA8Sa2MpkuHTS7KFMnDAswpuUYbVq6dSItdpyUvZOKA7vV5zfyqUGtWQRI05Q+LDOPZ5fGihZKmL+sCj4rWwMmVfoVCVBr6SGP/mYfIDfuFa6pqCi/sYsXrXCGnFe+yndMZGqyCA7XHiKX788SUxPJvvEky2BDEjKOt1thRgrGrL/42BIkaXpbCYaHlGajFGQnpNfYNuQ0bMvrdL9iGxBsz7QmiOAga640i+6pBmgvRTFa+ORlx+6lSUXgO3pjAlePHf5+Nah7WDBedcycSn2RJqxebsuWrt86DCZiZL8TNM8yLaf1QHI7zYdC4hGvam9ydOG37qrGX68Maz1gjThnZ9M2ZKZk/iFjyTCrVPEySJwqJ2yf/8YGcY6zvujH7gdpA7SelrhZmC2xIxkxHdHAhTLOjYvvE9wPl68ok+SwuIDocCT3TEhZDu/I/kmvjjmUuPJj8qjKvUDDzft+TbVZWQLlo8YGlunWYnKVtNPdNzfStIGoB++jL5h+QOEcO/Kkgiz2B90ufhg==
X-MS-Exchange-AntiSpam-MessageData: u+JIQLH49OZgu3ZR8RzHBvAoH1KrVSi5xERmL6FnC659DTuhEZ4UqctMkZoURcKy76IYbr5K89Oat0uRCL2koR2zyQbfHwimUe3/sQL9U/4XkSa2VJ+BLLRk6r6Qu9vOUZ0k0eHk8OxOKJcTyeuiOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7960a2-7668-486e-a4c9-08d7b553b6d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:52:25.2200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HpIyzvMnEU+y0Kc8gRc/4inNJgVxe0tD5PKs+cdw9CrYVtoy/z+qWbmRfIURQeL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks.

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

On 2020-02-19 9:24 a.m., Alex Deucher wrote:
> Use the existence of the workqueue itself to determine when to
> enable HDCP features rather than sprinkling asic checks all over
> the code.  Also add a check for the existence of the hdcp
> workqueue in the irq handling on the off chance we get and HPD
> RX interrupt with the CP bit set.  This avoids a crash if
> the driver doesn't support HDCP for a particular asic.
>
> Fixes: 96a3b32e67236f ("drm/amd/display: only enable HDCP for DCN+")
> Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D206519&amp;data=02%7C01%7Cbhawanpreet.lakha%40amd.com%7C0bb0c7154e6946e09b0c08d7b547766c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177190908488608&amp;sdata=AQqpGAH86XJj%2FtdLOWgWQchwffQYW2ob5aSXzJiaQJo%3D&amp;reserved=0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f7d541030698..4cb3eb7c6745 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1961,7 +1961,7 @@ static void handle_hpd_irq(void *param)
>   	mutex_lock(&aconnector->hpd_lock);
>   
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
> -	if (adev->asic_type >= CHIP_RAVEN)
> +	if (adev->dm.hdcp_workqueue)
>   		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
>   #endif
>   	if (aconnector->fake_enable)
> @@ -2138,8 +2138,10 @@ static void handle_hpd_rx_irq(void *param)
>   		}
>   	}
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
> -	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ)
> -		hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
> +	    if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
> +		    if (adev->dm.hdcp_workqueue)
> +			    hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
> +	    }
>   #endif
>   	if ((dc_link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
>   	    (dc_link->type == dc_connection_mst_branch))
> @@ -5836,7 +5838,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>   		drm_connector_attach_vrr_capable_property(
>   			&aconnector->base);
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
> -		if (adev->asic_type >= CHIP_RAVEN)
> +		if (adev->dm.hdcp_workqueue)
>   			drm_connector_attach_content_protection_property(&aconnector->base, true);
>   #endif
>   	}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
