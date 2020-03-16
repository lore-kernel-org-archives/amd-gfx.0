Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD46C18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 17:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D7F20674
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 17:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tfc2dZSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D7F20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA616E212;
	Mon, 16 Mar 2020 17:27:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1F66E20A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 17:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLBkXO7PofFL5glm/9fx/zkJTT72LL1+NjSoisvTxQsphQEyMOdHmv7OUf6CaSjn0ASu0RQEop/aSN+cja5EMgSSQXBmTG//DqvKGX6qF2ohGfthEehmzouG55X9OgblPmJM1zEwRw2UBTLPFfH9vR7QGqpk1RIwhj3iB+m+F6rrbvvXFmavXn1WoHcS2lXVvHkRnecMVW3jc1p09/2Q8qfqooiRLjcPouWtQAVW3tC0tuRp0PCIuPK14KfMS1R1HqKmxH6bdRs4nu/DED1CmmbI3v2lLlQXDDb9+dexYoyca8BjdT76Zwt9RAweZWasqqv9ebHtIY3jtv0tjTODZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdB4ifAuN6T46FhzNLqU0/e/u2KkCVY85i/FSwy63kI=;
 b=kMR2rLlWRPCuHB9ben+y0wHiryoPZqjTOKXuY22vmz6MJE29Fr8uBue5gc7ejMqKuLkf4ExzncWwRY+MjMUslXF7ryZQe1ByoDoY9kdnDgWu/fhvBln9fhu2x6vKhxAVSNr0D2BEc++RF97kB0tHjyWIvHJHeTRnj0g7U+jdLBhjvgpqAzwoRZNJZUIG8XLKQ2aqE5PhflLT6rZb28s0uiAT/yul7PcedWE4BpfYA8eJpsMKQTq4hQabPoIH7FW6FSZAB+Uo3ms1cJkKvx8mdVr3Qzi7XeKuHAtTgGOuiLbI8P+6Lo4iW0Z5UbVC0PfX6NeuY+wnmEdLxLrQPXW3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdB4ifAuN6T46FhzNLqU0/e/u2KkCVY85i/FSwy63kI=;
 b=tfc2dZSY92k9LcdyFDoqmiqAp9+euQYm8fnLF0lRJnuwGz1CMzuRB15vXEzmuFLn9uoM5O68SeaDhAWpPZMKkSgsID9JXoUceVdxpBv2vI0DJcfY/gCPHX4SZe6iHpLBgTzYDP0urd1HDia/C7eBxP/Vv4jMPYQAg/T4JWFGzf4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1693.namprd12.prod.outlook.com (2603:10b6:301:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Mon, 16 Mar
 2020 17:27:38 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 17:27:38 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
To: amd-gfx@lists.freedesktop.org
References: <1584155137-9628-1-git-send-email-andrey.grodzovsky@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <e0599f52-5cc7-e030-327d-350e9b8a1831@amd.com>
Date: Mon, 16 Mar 2020 13:27:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <1584155137-9628-1-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35)
 To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 17:27:37 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73ba1d0e-c641-4743-963c-08d7c9cf5285
X-MS-TrafficTypeDiagnostic: MWHPR12MB1693:|MWHPR12MB1693:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1693B715ED13435EE91B26A6EAF90@MWHPR12MB1693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(66946007)(36756003)(2906002)(66476007)(53546011)(81166006)(86362001)(2616005)(4326008)(66556008)(31696002)(16576012)(81156014)(6486002)(956004)(8936002)(8676002)(6916009)(31686004)(52116002)(5660300002)(316002)(186003)(478600001)(16526019)(26005)(30864003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1693;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSaCCeXiCCN8g1Gbe6TEy1hPIO/fkF9IcF8gU7vmB7YSTLqXy1GjWF1D57CEOlf/3uLxnKiiNt/6GgKPuIERnvpMHx4PdwC4KLf6La2N3ChYOOfTz0BLbjkS3Z01sTxf52IWYZRx3UBlqWbUK5Ni4fiTW9nvOGmaHoxRZNNCEj3DDskTbdC8P16ybe8xwg4OGfy7VeKtaua6g0rrw1H2QLEbJQpNNuyomT1INRYlrW9WK9uLnXmo/jpyHoayKzXrjSoDZ9nfm1KXFLsOK7dcCA5MPvDhEvvsqkNsqYmO3Qsv7bxui6MR6o1qyx4LKVLcuipMVvR6cVPOR4KoGwsTbKQuJ9G/pN75fRlJFdyimYHHprGCbldToL4y5UW9aijDLH5Duzb+dhDZyK70D3jH8ssFVKxfbZzLQtoiRBboTHa4Qu498RFCvRoZgPuS0Q84
X-MS-Exchange-AntiSpam-MessageData: NoICTd4FByFyN7zbZNxkPuOKKZi8sTb5AdrJWkDUzFyCLL3XA+wlIfHZb3hjc/n29BxsUdRe0lDxkP5tXZiFuAXAQCSrmMsjudQhnKGYTpmRGWXYILQV585KIPJAu559l+iK8vLZAf18lM0Ot7FF5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ba1d0e-c641-4743-963c-08d7c9cf5285
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 17:27:37.9182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU5atoqpoO403NubLFyELzeIoqAi+2uqFbxljhPWEAEPrACeKgbk+ML2d1PGCLBr73yYHSdC3ChIq7sXD6LPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1693
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
Cc: Alexander.Deucher@amd.com, Kent.Russell@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping

Andrey

On 3/13/20 11:05 PM, Andrey Grodzovsky wrote:
> Puts the i2c adapter in common place for sharing by RAS
> and upcoming data read from FRU EEPROM feature.
>
> v2:
> Move i2c adapter to amdgpu_pm and rename it.
>
> v3: Move i2c adapter init to ASIC specific code and get rid
> of the switch case in amdgpu_device
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     | 48 ++++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |  2 -
>   drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         | 14 ++++---
>   drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 10 +++++
>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  4 +-
>   .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   | 11 +++++
>   7 files changed, 41 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> index 1685794..936d85a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> @@ -448,6 +448,8 @@ struct amdgpu_pm {
>   	/* powerplay feature */
>   	uint32_t pp_feature;
>   
> +	/* Used for I2C access to various EEPROMs on relevant ASICs */
> +	struct i2c_adapter smu_i2c;
>   };
>   
>   #define R600_SSTU_DFLT                               0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index ed15b1f..c009609 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -25,7 +25,6 @@
>   #include "amdgpu.h"
>   #include "amdgpu_ras.h"
>   #include <linux/bits.h>
> -#include "smu_v11_0_i2c.h"
>   #include "atom.h"
>   
>   #define EEPROM_I2C_TARGET_ADDR_VEGA20    	0xA0
> @@ -124,6 +123,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>   				 unsigned char *buff)
>   {
>   	int ret = 0;
> +	struct amdgpu_device *adev = to_amdgpu_device(control);
>   	struct i2c_msg msg = {
>   			.addr	= 0,
>   			.flags	= 0,
> @@ -137,7 +137,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>   
>   	msg.addr = control->i2c_address;
>   
> -	ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
> +	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
>   	if (ret < 1)
>   		DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
>   
> @@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>   			.buf	= buff,
>   	};
>   
> +	/* Verify i2c adapter is initialized */
> +	if (!adev->pm.smu_i2c.algo)
> +		return -ENOENT;
> +
>   	if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
>   		return -EINVAL;
>   
>   	mutex_init(&control->tbl_mutex);
>   
> -	switch (adev->asic_type) {
> -	case CHIP_VEGA20:
> -		ret = smu_v11_0_i2c_eeprom_control_init(&control->eeprom_accessor);
> -		break;
> -
> -	case CHIP_ARCTURUS:
> -		ret = smu_i2c_eeprom_init(&adev->smu, &control->eeprom_accessor);
> -		break;
> -
> -	default:
> -		return 0;
> -	}
> -
> -	if (ret) {
> -		DRM_ERROR("Failed to init I2C controller, ret:%d", ret);
> -		return ret;
> -	}
> -
>   	msg.addr = control->i2c_address;
> -
>   	/* Read/Create table header from EEPROM address 0 */
> -	ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
> +	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
>   	if (ret < 1) {
>   		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
>   		return ret;
> @@ -303,23 +288,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>   	return ret == 1 ? 0 : -EIO;
>   }
>   
> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control)
> -{
> -	struct amdgpu_device *adev = to_amdgpu_device(control);
> -
> -	switch (adev->asic_type) {
> -	case CHIP_VEGA20:
> -		smu_v11_0_i2c_eeprom_control_fini(&control->eeprom_accessor);
> -		break;
> -	case CHIP_ARCTURUS:
> -		smu_i2c_eeprom_fini(&adev->smu, &control->eeprom_accessor);
> -		break;
> -
> -	default:
> -		return;
> -	}
> -}
> -
>   static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
>   					  struct eeprom_table_record *record,
>   					  unsigned char *buff)
> @@ -476,7 +444,7 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
>   		control->next_addr += EEPROM_TABLE_RECORD_SIZE;
>   	}
>   
> -	ret = i2c_transfer(&control->eeprom_accessor, msgs, num);
> +	ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
>   	if (ret < 1) {
>   		DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index ca78f81..7e8647a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -44,7 +44,6 @@ struct amdgpu_ras_eeprom_table_header {
>   
>   struct amdgpu_ras_eeprom_control {
>   	struct amdgpu_ras_eeprom_table_header tbl_hdr;
> -	struct i2c_adapter eeprom_accessor;
>   	uint32_t next_addr;
>   	unsigned int num_recs;
>   	struct mutex tbl_mutex;
> @@ -79,7 +78,6 @@ struct eeprom_table_record {
>   }__attribute__((__packed__));
>   
>   int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control);
>   int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
>   
>   int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index c902f26..9bffbab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -46,8 +46,7 @@
>   #define I2C_NO_STOP	1
>   #define I2C_RESTART	2
>   
> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
> -#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>   
>   static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
>   {
> @@ -592,7 +591,8 @@ static uint32_t smu_v11_0_i2c_eeprom_write_data(struct i2c_adapter *control,
>   
>   static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
>   {
> -	struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
> +	struct amdgpu_device *adev = to_amdgpu_device(i2c);
> +	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>   
>   	if (!smu_v11_0_i2c_bus_lock(i2c)) {
>   		DRM_ERROR("Failed to lock the bus from SMU");
> @@ -610,7 +610,8 @@ static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
>   
>   static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
>   {
> -	struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
> +	struct amdgpu_device *adev = to_amdgpu_device(i2c);
> +	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>   
>   	if (!smu_v11_0_i2c_bus_unlock(i2c)) {
>   		DRM_ERROR("Failed to unlock the bus from SMU");
> @@ -630,7 +631,8 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			      struct i2c_msg *msgs, int num)
>   {
>   	int i, ret;
> -	struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c_adap);
> +	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
> +	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>   
>   	if (!control->bus_locked) {
>   		DRM_ERROR("I2C bus unlocked, stopping transaction!");
> @@ -679,7 +681,7 @@ int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
>   	control->class = I2C_CLASS_SPD;
>   	control->dev.parent = &adev->pdev->dev;
>   	control->algo = &smu_v11_0_i2c_eeprom_i2c_algo;
> -	snprintf(control->name, sizeof(control->name), "RAS EEPROM");
> +	snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
>   	control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
>   
>   	res = i2c_add_adapter(control);
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 8de8436..0273c63 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -932,6 +932,13 @@ static int smu_sw_init(void *handle)
>   		return ret;
>   	}
>   
> +	if (adev->smu.ppt_funcs->i2c_eeprom_init) {
> +		ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -941,6 +948,9 @@ static int smu_sw_fini(void *handle)
>   	struct smu_context *smu = &adev->smu;
>   	int ret;
>   
> +	if (adev->smu.ppt_funcs->i2c_eeprom_fini)
> +		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
> +
>   	kfree(smu->irq_source);
>   	smu->irq_source = NULL;
>   
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 61596e8..c6d3bef 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -41,7 +41,7 @@
>   #include <linux/pci.h>
>   #include "amdgpu_ras.h"
>   
> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>   
>   #define CTF_OFFSET_EDGE			5
>   #define CTF_OFFSET_HOTSPOT		5
> @@ -2190,7 +2190,7 @@ static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>   	control->class = I2C_CLASS_SPD;
>   	control->dev.parent = &adev->pdev->dev;
>   	control->algo = &arcturus_i2c_eeprom_i2c_algo;
> -	snprintf(control->name, sizeof(control->name), "RAS EEPROM");
> +	snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
>   
>   	res = i2c_add_adapter(control);
>   	if (res)
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> index 49e5ef3..16aa171 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> @@ -33,6 +33,8 @@
>   #include "smu7_smumgr.h"
>   #include "vega20_hwmgr.h"
>   
> +#include "smu_v11_0_i2c.h"
> +
>   /* MP Apertures */
>   #define MP0_Public			0x03800000
>   #define MP0_SRAM			0x03900000
> @@ -406,6 +408,7 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
>   	struct vega20_smumgr *priv;
>   	unsigned long tools_size = 0x19000;
>   	int ret = 0;
> +	struct amdgpu_device *adev = hwmgr->adev;
>   
>   	struct cgs_firmware_info info = {0};
>   
> @@ -505,6 +508,10 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
>   	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].version = 0x01;
>   	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size = sizeof(DpmActivityMonitorCoeffInt_t);
>   
> +	ret = smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
> +	if (ret)
> +		goto err4;
> +
>   	return 0;
>   
>   err4:
> @@ -537,6 +544,9 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
>   {
>   	struct vega20_smumgr *priv =
>   			(struct vega20_smumgr *)(hwmgr->smu_backend);
> +	struct amdgpu_device *adev = hwmgr->adev;
> +
> +	smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
>   
>   	if (priv) {
>   		amdgpu_bo_free_kernel(&priv->smu_tables.entry[TABLE_PPTABLE].handle,
> @@ -560,6 +570,7 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
>   		kfree(hwmgr->smu_backend);
>   		hwmgr->smu_backend = NULL;
>   	}
> +
>   	return 0;
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
