Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46756C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 19:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040BE21835
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 19:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eaBoRrb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040BE21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B114A6F882;
	Wed, 22 Jan 2020 19:03:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BAA6F882
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 19:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im3GyxiXIdvBCkruMrK/GMzvQpXK8MJsGjf4ZeUOa8P2P4nxMZRLqfo+IGo2vwlHl/54V4MKaS4fGGRP9XCwE45D8EHqyBT5C4gcvnkk0WAh6MRlQ9SLWE3fkc0+4rAByFZqTDNiurW4i46qs9uBQqf2blbRtmtGlotyK3P1frET4SHk3OTK7OMqrbTD4TUFGAhhb0eb4o1FprIsD9uPBsFN7tMaWuOddbMRVvCLjiL8oE/rGjggn2V4n9oNiZxIsbghP+t47Vco/GlokAJbRbKNU9inOUblOElAyGpkq4U0uVu+1X2AE/qMkhrRtSi5e7RhdnuGtX5azWaf0vd5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mnowz6Oc8Po4b/9CXr/CZ5QTIyVULn9go1t+TiyVSc=;
 b=mDDz+k2N1hInhBkquY+IksA/dx717QXdjOo9MhGP7Sn9xojFToNj1AA7/I3CthbVFIDMHE0xtre5yS+nO/1Lf6WAgvR6rmTIGgaiIYJd59tNXZAPUs+cRvvx8uf46fxpcY4C9hxL3YgFjIRqljNjlVratizUFLDmCIxdyBkVpYSYrkUPFkN0Kz+vre+4xHt/4+ErZs5VnwqE75J0WUoneYwZRcWovFp7t07UwL8i+njayLXPt8mf7GcH1ksOkNeuGeShRcrQUbyAZa3rG3nQTI7GlUSTKfcg830zibBqAYb33MxE/LtJL7b5aJp7aAtfBnC/woyprMUz8IvJMrMAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mnowz6Oc8Po4b/9CXr/CZ5QTIyVULn9go1t+TiyVSc=;
 b=eaBoRrb2VZ1US8+kyl6dMvQ74mgOxHHjIftg7CiOWffUuFRai8HPsjbcbccJ+XIgexqVCCYEj6675bg8Hz7ihBqHn6BcyugKwaFoEJL2bwj1/vaDG2fbQQCP8wAJXA9YWFRjyvDY4+XUsv45vNDPI06oZmKdnLJnoMeNceKSiHs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com (10.174.115.135) by
 BN6PR1201MB0068.namprd12.prod.outlook.com (10.174.113.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Wed, 22 Jan 2020 19:03:48 +0000
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2]) by BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2%3]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 19:03:48 +0000
Subject: Re: [PATCH 3/5] drm/amd/display: Add sysfs interface for set/get srm
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <20200116202945.21801-4-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <10622fcc-ade9-4160-c73f-a831dd656656@amd.com>
Date: Wed, 22 Jan 2020 14:03:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200116202945.21801-4-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::48) To BN6PR1201MB0228.namprd12.prod.outlook.com
 (2603:10b6:405:57::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTOPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Wed, 22 Jan 2020 19:03:47 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd2f405d-c835-4eae-d3ba-08d79f6dcf7b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0068:|BN6PR1201MB0068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0068C2C939E91C2E137D72818C0C0@BN6PR1201MB0068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(53546011)(36756003)(5660300002)(52116002)(16576012)(316002)(26005)(8676002)(186003)(2906002)(16526019)(478600001)(2616005)(956004)(4326008)(81156014)(81166006)(8936002)(66556008)(66946007)(66476007)(31686004)(6486002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0068;
 H:BN6PR1201MB0228.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9AWCQQ22ngKdEx4DhOgwh8+jNWgr1AgsqrWFbPQ8eIBpG/J1L1wIeDMHJN8y1ZJpq3454RpQiGCK681s3yq5AWr6tkdheTUAo1oLLqYZIdXrq3BnzM1Nzgx/btK6fFxyAJuX1I2VAJxnpHEx+K2VNy+Yj7VMX0ceNfbu92R/aYWG5lPMcguzF3cmHKtOwrG8ipptq9m1NMLk95WgSbkrSHua3hPGihT7sH1fXC5LBAeHyOab8e857ejnO+33doR5o8EGhfX6uvHWopodmVJwPSZZvfMVtSjU8aMXR1GqxHG10UAi6mKEwmUvlk+vsJzOT6CRabF8Kday4osRHvfKXWXonTjDD736Jsmwbw4C98T9lePaK9laWlgx1JBjiKT1w8KfvPzgdTrD7EuslXmUN0TgmiE9yJ+EUsMWG1NEm89ArHLYrnyILl5UTb+vBw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2f405d-c835-4eae-d3ba-08d79f6dcf7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 19:03:48.0923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTrBNEbKZ6PuEtp8a6F8TrONjcdh6FkHaFalywG//oIYs7T93Njvg+yIFry2m2xDnD44jD8Q07u8/gGWsQzdSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0068
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
Cc: harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-16 3:29 p.m., Bhawanpreet Lakha wrote:
> [Why]
> We need to set/get SRM and linux kernel is not suppose to write to the

"We need to set/get SRM from/to PSP FW..."

> storage, so we need to provide a interface.
> 

an interface.

Highlight that we expect these to be exercised by usermode scripts that
run at boot, shutdown, suspend, and resume.

Harry

> [How]
> Provide interface so usermode can set/get srm
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 124 +++++++++++++++++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   6 +
>  2 files changed, 128 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index a269916f7dd6..a191c84ad8eb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -28,6 +28,8 @@
>  #include "amdgpu_dm.h"
>  #include "dm_helpers.h"
>  #include <drm/drm_hdcp.h>
> +#include "hdcp_psp.h"
> +
>  
>  static bool
>  lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
> @@ -67,6 +69,16 @@ lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
>  	return dm_helpers_dp_read_dpcd(link->ctx, link, address, data, size);
>  }
>  
> +static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
> +{
> +	return NULL;
> +}
> +
> +static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size, uint32_t *srm_version)
> +{
> +	return 0;
> +}
> +
>  static void process_output(struct hdcp_workqueue *hdcp_work)
>  {
>  	struct mod_hdcp_output output = hdcp_work->output;
> @@ -88,6 +100,18 @@ static void process_output(struct hdcp_workqueue *hdcp_work)
>  	schedule_delayed_work(&hdcp_work->property_validate_dwork, msecs_to_jiffies(0));
>  }
>  
> +static void link_lock(struct hdcp_workqueue *work, bool lock)
> +{
> +
> +	int i = 0;
> +
> +	for (i = 0; i < work->max_link; i++) {
> +		if (lock)
> +			mutex_lock(&work[i].mutex);
> +		else
> +			mutex_unlock(&work[i].mutex);
> +	}
> +}
>  void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
>  			 unsigned int link_index,
>  			 struct amdgpu_dm_connector *aconnector,
> @@ -302,7 +326,8 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
>  	}
>  
>  	kfree(hdcp_work);
> -
> +	kfree(hdcp_work->srm);
> +	kfree(hdcp_work->srm_temp);
>  }
>  
>  static void update_config(void *handle, struct cp_psp_stream_config *config)
> @@ -338,6 +363,84 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>  	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
>  }
>  
> +
> +/*
> + * This can be called twice, because SRM_SIZE > PAGE_SIZE.
> + *
> + * We set the SRM on each call, if SRM_SIZE > PAGE_SIZE, PSP will fail on the
> + * first call but pass on the second call.
> + *
> + * Because of this we are not throwing any errors as it will stop the next call.
> + * So it is a good idea to call the "read" sysfs to verify that the SRM was set
> + *
> + */
> +static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
> +			      loff_t pos, size_t count)
> +{
> +	struct hdcp_workqueue *work;
> +	uint32_t srm_version = 0;
> +
> +	work = container_of(bin_attr, struct hdcp_workqueue, attr);
> +	link_lock(work, true);
> +
> +	memcpy(work->srm_temp + pos, buffer, count);
> +
> +	if (!psp_set_srm(work->hdcp.config.psp.handle, work->srm_temp, pos + count, &srm_version)) {
> +		DRM_DEBUG_DRIVER("HDCP SRM SET version 0x%X", srm_version);
> +		memcpy(work->srm, work->srm_temp, pos + count);
> +		work->srm_size = pos + count;
> +		work->srm_version = srm_version;
> +	}
> +
> +
> +	link_lock(work, false);
> +
> +	return count;
> +}
> +
> +static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
> +			     loff_t pos, size_t count)
> +{
> +	struct hdcp_workqueue *work;
> +	uint8_t *srm = NULL;
> +	uint32_t srm_version;
> +	uint32_t srm_size;
> +	size_t ret = count;
> +
> +	work = container_of(bin_attr, struct hdcp_workqueue, attr);
> +
> +	link_lock(work, true);
> +
> +	srm = psp_get_srm(work->hdcp.config.psp.handle, &srm_version, &srm_size);
> +
> +	if (!srm)
> +		return -EINVAL;
> +
> +	if (pos >= srm_size)
> +		ret = 0;
> +
> +	if (srm_size - pos < count) {
> +		memcpy(buffer, srm + pos, srm_size - pos);
> +		ret = srm_size - pos;
> +		goto ret;
> +	}
> +
> +	memcpy(buffer, srm + pos, count);
> +
> +ret:
> +	link_lock(work, false);
> +	return ret;
> +}
> +
> +
> +static const struct bin_attribute data_attr = {
> +	.attr = {.name = "hdcp_srm", .mode = 0664},
> +	.size = PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, /* Limit SRM size */
> +	.write = srm_data_write,
> +	.read = srm_data_read,
> +};
> +
> +
>  struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc)
>  {
>  
> @@ -348,10 +451,19 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
>  	if (hdcp_work == NULL)
>  		goto fail_alloc_context;
>  
> +	hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm), GFP_KERNEL);
> +
> +	if (hdcp_work->srm == NULL)
> +		goto fail_alloc_context;
> +
> +	hdcp_work->srm_temp = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm_temp), GFP_KERNEL);
> +
> +	if (hdcp_work->srm_temp == NULL)
> +		goto fail_alloc_context;
> +
>  	hdcp_work->max_link = max_caps;
>  
>  	for (i = 0; i < max_caps; i++) {
> -
>  		mutex_init(&hdcp_work[i].mutex);
>  
>  		INIT_WORK(&hdcp_work[i].cpirq_work, event_cpirq);
> @@ -371,10 +483,18 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
>  	cp_psp->funcs.update_stream_config = update_config;
>  	cp_psp->handle = hdcp_work;
>  
> +	/* File created at /sys/class/drm/card0/device/hdcp_srm*/
> +	hdcp_work[0].attr = data_attr;
> +
> +	if (sysfs_create_bin_file(&adev->dev->kobj, &hdcp_work[0].attr))
> +		DRM_WARN("Failed to create device file hdcp_srm");
> +
>  	return hdcp_work;
>  
>  fail_alloc_context:
>  	kfree(hdcp_work);
> +	kfree(hdcp_work->srm);
> +	kfree(hdcp_work->srm_temp);
>  
>  	return NULL;
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> index 331b50825510..5159b3a5e5b0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> @@ -53,6 +53,12 @@ struct hdcp_workqueue {
>  
>  	enum mod_hdcp_encryption_status encryption_status;
>  	uint8_t max_link;
> +
> +	uint8_t *srm;
> +	uint8_t *srm_temp;
> +	uint32_t srm_version;
> +	uint32_t srm_size;
> +	struct bin_attribute attr;
>  };
>  
>  void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
