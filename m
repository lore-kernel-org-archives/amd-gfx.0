Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14543C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61BD20717
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zlf3RRHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61BD20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932AF6E040;
	Tue, 21 Jul 2020 18:01:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770043.outbound.protection.outlook.com [40.107.77.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB1D6E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNqrI//nTPXi0rj/OtnLlFLguTHJuZC6z7seRKbrgvXTQ6xLsuo6zvKsrEZ0j9wgLKMxqQVTLYTqzhsb9RoX6z32DXlMEgcjc5NoRov8pXNCgjaD8JIXreLUwHHQQ9K3y6Gs+ePXQo4EKq6CWNGuCh6hI+t+HFmaEdVF8NN4ZaGfDS3nHuK7EXeS0J3eH1zdnJEV4jNHNXF3oVpQ3gP5vPHX2r8LvlBG01fRSEVvmjgXmd90J7UIgyL3e8o+wsccEXR68vF7bIRVMSurl03Pf3l9UGafKbEh77bIiqwR43+5Z3FbG4oZJgnAY7Kq2SJNhQVWNunBmk+Ccz8n3avO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSVAIlSC6aYvVTEoATUZyyUdO2L2RqqYITm0S1K/5cs=;
 b=d4KHuebWoUO7AksnkTTQG/PPxquX3ctZMsWiku0CZ//Io5BwvAruGAkfT45SHcuZw1+W4seKMhfkZtWX/jlhw9ZJVXyZ2tfKfLqU+AKOC0pALPfg1M5cQvXFXQpzOaxg1Rcy0/gfN2qOsVnWBi1FWSlqp7+953AeRZRXX62qQboLo9lbe96Y5prnPr4C1XCZsTrhB2ZFxGMtK7e9ePxiPgSo3wXtZ39OCGul69lxKjEcqgIZ1qPYmn5QIYXA0rMP8TfMDV7J+IRY9uIFaykViuLPRND+0c7MmEtNHlOREukVcLwu5VP+YNmnMZdR5WxADwlPlepqLiJeRI66FYsOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSVAIlSC6aYvVTEoATUZyyUdO2L2RqqYITm0S1K/5cs=;
 b=zlf3RRHDGZ+eH975a38k89h/mN+LhKZfac3hCsGGRFwX+UcixiayZbejtxX8a5hvyEtH0iHm9xhlY0X8Eegf/HIQBGliG3KjGQ6gHGNvc1IxmqCoHN7cUxQmQRSdlUDd4VvzfkEDMoteoFx55uI1hKCCBeNab6azrs6WN/kG0d8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Tue, 21 Jul 2020 18:01:24 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%4]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 18:01:24 +0000
Subject: Re: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c support
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200721165240.296265-1-alexander.deucher@amd.com>
 <20200721165240.296265-6-alexander.deucher@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <b71640ad-bdcf-1cfa-bf78-c90253321805@amd.com>
Date: Tue, 21 Jul 2020 14:01:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200721165240.296265-6-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:408:e6::16) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:646c:e41c:908f:f19b]
 (2607:fea8:3edf:49b0:646c:e41c:908f:f19b) by
 BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.19 via Frontend Transport; Tue, 21 Jul 2020 18:01:24 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:646c:e41c:908f:f19b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbadeead-129c-4114-b57e-08d82da0152b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212A8AF583A6731F63A8730EA780@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooyPfXmjsPerNrJApRHvqi8Ntms04mjvtCVrRW8X58DZtpJO3K+9upGlz4tN1sR0/Y69LWY466zJjuyachze1YMQ4YDW6xUZlJeixKMMmChjde/2yJVIIcMkeIksYCeoYQXgHVJm8L4o5G7mwN6VKMvWehU6MITjHhbo8tAXS+M4inOqdQCJBcX0P24OsygmfkXWWf9OHlk55d0gv07GH3JwbTIyM1YliGpe2GHgZYMBdSGs5IRbMI8bgRtkgGP2OUwE2l5QuhYjStNKfz8kTlv2CpNUiJukaWmHY78mQ+4C7aaoAKwFxM4J+IaRoHhSuWvIMtkkVgZ2Jhy0Lbtjpxvj5TT2yVbHkmDFcLelYCUjKyqX7pLSg9H0WWvgfDPo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(66946007)(66476007)(66556008)(83380400001)(2906002)(478600001)(2616005)(5660300002)(86362001)(316002)(6486002)(8936002)(8676002)(31686004)(16526019)(186003)(31696002)(53546011)(52116002)(4326008)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qGcFgH9IE2TDe7kfLygHAUsN17G9i7/P8xnbPmROOa/mfex9PGgki192YJI9dnh7zvRxoSeh8PVyWA9O7l6URIPFLUoTGK7dMXzxYAFi65EwQ86jfw/jQVtlGHcZkJrpz78AX/0j2mofekKjmqBR/sXX0AWCrJ5JhQtMAldb+ny4FQCLVRlh0mosg0vESEwnMrd0jC3LFe8WS0RsKIPZvsF/bPJhp5b/G+/8Awo7CzEA8+l4qsW0CkxDWh//1rZquZ9M897XGbqmXJB/QPs9eSmGVxCsv8E2X0mtotVCgZNs42x7+ERnYx8iCotkgQa7i8Z9AlR95WnwkdOrJCWkneNjPQwPTWcK6jH8ohQfHDWH3FMP5uGigtmHnHROYOsfsiV/OqmgnBOhNF8ETI8HI31U9foWxbeu2djqovCyVOH6GxCVOcVK75qS97pb+n/vnY+rmqsaNhgrpWGu6+jdSNxuDEEds7jseQfXowDSkObRj4by1vApB0Wlf0CZ/quV7yAplxB1tWh6f92z9YpkbqkNYWIaD9bfjSfsk6wuxdFsbWyx8Zkts28L6AtIEA71
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbadeead-129c-4114-b57e-08d82da0152b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 18:01:24.7358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBePjottmNKSP7cdoNNGmYVQnMMRziFFDvx0d1HxDN5ZwNerEsYxMj1s/uT8LOKMSDFPy1BcIYbw7YgxrsnXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

Series besides patch 5/6 which you said is the wrong version is Reviewed-by: 
Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 7/21/20 12:52 PM, Alex Deucher wrote:
> Enable SMU i2c bus access for sienna_cichlid asics.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 239 ++++++++++++++++++
>   1 file changed, 239 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 5faef41b63a3..e1857fbb0a6f 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -23,6 +23,7 @@
>   
>   #include <linux/firmware.h>
>   #include <linux/pci.h>
> +#include <linux/i2c.h>
>   #include "amdgpu.h"
>   #include "amdgpu_smu.h"
>   #include "smu_internal.h"
> @@ -52,6 +53,8 @@
>   #undef pr_info
>   #undef pr_debug
>   
> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
> +
>   #define FEATURE_MASK(feature) (1ULL << feature)
>   #define SMC_DPM_FEATURE ( \
>   	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
> @@ -455,6 +458,8 @@ static int sienna_cichlid_tables_init(struct smu_context *smu, struct smu_table
>   		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
>   		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
> +		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   	SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTable_t),
>   		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   	SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU11_TOOL_SIZE,
> @@ -2487,6 +2492,238 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
>   	dev_info(smu->adev->dev, "MmHubPadding[7] = 0x%x\n", pptable->MmHubPadding[7]);
>   }
>   
> +static void sienna_cichlid_fill_i2c_req(SwI2cRequest_t  *req, bool write,
> +				  uint8_t address, uint32_t numbytes,
> +				  uint8_t *data)
> +{
> +	int i;
> +
> +	BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);
> +
> +	req->I2CcontrollerPort = 0;
> +	req->I2CSpeed = 2;
> +	req->SlaveAddress = address;
> +	req->NumCmds = numbytes;
> +
> +	for (i = 0; i < numbytes; i++) {
> +		SwI2cCmd_t *cmd =  &req->SwI2cCmds[i];
> +
> +		/* First 2 bytes are always write for lower 2b EEPROM address */
> +		if (i < 2)
> +			cmd->CmdConfig = CMDCONFIG_READWRITE_MASK;
> +		else
> +			cmd->CmdConfig = write ? CMDCONFIG_READWRITE_MASK : 0;
> +
> +
> +		/* Add RESTART for read  after address filled */
> +		cmd->CmdConfig |= (i == 2 && !write) ? CMDCONFIG_RESTART_MASK : 0;
> +
> +		/* Add STOP in the end */
> +		cmd->CmdConfig |= (i == (numbytes - 1)) ? CMDCONFIG_STOP_MASK : 0;
> +
> +		/* Fill with data regardless if read or write to simplify code */
> +		cmd->ReadWriteData = data[i];
> +	}
> +}
> +
> +static int sienna_cichlid_i2c_read_data(struct i2c_adapter *control,
> +					       uint8_t address,
> +					       uint8_t *data,
> +					       uint32_t numbytes)
> +{
> +	uint32_t  i, ret = 0;
> +	SwI2cRequest_t req;
> +	struct amdgpu_device *adev = to_amdgpu_device(control);
> +	struct smu_table_context *smu_table = &adev->smu.smu_table;
> +	struct smu_table *table = &smu_table->driver_table;
> +
> +	memset(&req, 0, sizeof(req));
> +	sienna_cichlid_fill_i2c_req(&req, false, address, numbytes, data);
> +
> +	mutex_lock(&adev->smu.mutex);
> +	/* Now read data starting with that address */
> +	ret = smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req,
> +					true);
> +	mutex_unlock(&adev->smu.mutex);
> +
> +	if (!ret) {
> +		SwI2cRequest_t *res = (SwI2cRequest_t *)table->cpu_addr;
> +
> +		/* Assume SMU  fills res.SwI2cCmds[i].Data with read bytes */
> +		for (i = 0; i < numbytes; i++)
> +			data[i] = res->SwI2cCmds[i].ReadWriteData;
> +
> +		dev_dbg(adev->dev, "sienna_cichlid_i2c_read_data, address = %x, bytes = %d, data :",
> +				  (uint16_t)address, numbytes);
> +
> +		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
> +			       8, 1, data, numbytes, false);
> +	} else
> +		dev_err(adev->dev, "sienna_cichlid_i2c_read_data - error occurred :%x", ret);
> +
> +	return ret;
> +}
> +
> +static int sienna_cichlid_i2c_write_data(struct i2c_adapter *control,
> +						uint8_t address,
> +						uint8_t *data,
> +						uint32_t numbytes)
> +{
> +	uint32_t ret;
> +	SwI2cRequest_t req;
> +	struct amdgpu_device *adev = to_amdgpu_device(control);
> +
> +	memset(&req, 0, sizeof(req));
> +	sienna_cichlid_fill_i2c_req(&req, true, address, numbytes, data);
> +
> +	mutex_lock(&adev->smu.mutex);
> +	ret = smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
> +	mutex_unlock(&adev->smu.mutex);
> +
> +	if (!ret) {
> +		dev_dbg(adev->dev, "sienna_cichlid_i2c_write(), address = %x, bytes = %d , data: ",
> +					 (uint16_t)address, numbytes);
> +
> +		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
> +			       8, 1, data, numbytes, false);
> +		/*
> +		 * According to EEPROM spec there is a MAX of 10 ms required for
> +		 * EEPROM to flush internal RX buffer after STOP was issued at the
> +		 * end of write transaction. During this time the EEPROM will not be
> +		 * responsive to any more commands - so wait a bit more.
> +		 */
> +		msleep(10);
> +
> +	} else
> +		dev_err(adev->dev, "sienna_cichlid_i2c_write- error occurred :%x", ret);
> +
> +	return ret;
> +}
> +
> +static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
> +			      struct i2c_msg *msgs, int num)
> +{
> +	uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr = 0;
> +	uint8_t *data_ptr, data_chunk[MAX_SW_I2C_COMMANDS] = { 0 };
> +
> +	for (i = 0; i < num; i++) {
> +		/*
> +		 * SMU interface allows at most MAX_SW_I2C_COMMANDS bytes of data at
> +		 * once and hence the data needs to be spliced into chunks and sent each
> +		 * chunk separately
> +		 */
> +		data_size = msgs[i].len - 2;
> +		data_chunk_size = MAX_SW_I2C_COMMANDS - 2;
> +		next_eeprom_addr = (msgs[i].buf[0] << 8 & 0xff00) | (msgs[i].buf[1] & 0xff);
> +		data_ptr = msgs[i].buf + 2;
> +
> +		for (j = 0; j < data_size / data_chunk_size; j++) {
> +			/* Insert the EEPROM dest addess, bits 0-15 */
> +			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
> +			data_chunk[1] = (next_eeprom_addr & 0xff);
> +
> +			if (msgs[i].flags & I2C_M_RD) {
> +				ret = sienna_cichlid_i2c_read_data(i2c_adap,
> +							     (uint8_t)msgs[i].addr,
> +							     data_chunk, MAX_SW_I2C_COMMANDS);
> +
> +				memcpy(data_ptr, data_chunk + 2, data_chunk_size);
> +			} else {
> +
> +				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
> +
> +				ret = sienna_cichlid_i2c_write_data(i2c_adap,
> +							      (uint8_t)msgs[i].addr,
> +							      data_chunk, MAX_SW_I2C_COMMANDS);
> +			}
> +
> +			if (ret) {
> +				num = -EIO;
> +				goto fail;
> +			}
> +
> +			next_eeprom_addr += data_chunk_size;
> +			data_ptr += data_chunk_size;
> +		}
> +
> +		if (data_size % data_chunk_size) {
> +			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
> +			data_chunk[1] = (next_eeprom_addr & 0xff);
> +
> +			if (msgs[i].flags & I2C_M_RD) {
> +				ret = sienna_cichlid_i2c_read_data(i2c_adap,
> +							     (uint8_t)msgs[i].addr,
> +							     data_chunk, (data_size % data_chunk_size) + 2);
> +
> +				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
> +			} else {
> +				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
> +
> +				ret = sienna_cichlid_i2c_write_data(i2c_adap,
> +							      (uint8_t)msgs[i].addr,
> +							      data_chunk, (data_size % data_chunk_size) + 2);
> +			}
> +
> +			if (ret) {
> +				num = -EIO;
> +				goto fail;
> +			}
> +		}
> +	}
> +
> +fail:
> +	return num;
> +}
> +
> +static u32 sienna_cichlid_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +
> +static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
> +	.master_xfer = sienna_cichlid_i2c_xfer,
> +	.functionality = sienna_cichlid_i2c_func,
> +};
> +
> +static bool sienna_cichlid_i2c_adapter_is_added(struct i2c_adapter *control)
> +{
> +	struct amdgpu_device *adev = to_amdgpu_device(control);
> +
> +	return control->dev.parent == &adev->pdev->dev;
> +}
> +
> +static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
> +{
> +	struct amdgpu_device *adev = to_amdgpu_device(control);
> +	int res;
> +
> +	/* smu_i2c_eeprom_init may be called twice in sriov */
> +	if (sienna_cichlid_i2c_adapter_is_added(control))
> +		return 0;
> +
> +	control->owner = THIS_MODULE;
> +	control->class = I2C_CLASS_SPD;
> +	control->dev.parent = &adev->pdev->dev;
> +	control->algo = &sienna_cichlid_i2c_algo;
> +	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
> +
> +	res = i2c_add_adapter(control);
> +	if (res)
> +		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
> +
> +	return res;
> +}
> +
> +static void sienna_cichlid_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
> +{
> +	if (!sienna_cichlid_i2c_adapter_is_added(control))
> +		return;
> +
> +	i2c_del_adapter(control);
> +}
> +
> +
>   static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.tables_init = sienna_cichlid_tables_init,
>   	.alloc_dpm_context = sienna_cichlid_allocate_dpm_context,
> @@ -2500,6 +2737,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
>   	.dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
>   	.dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
> +	.i2c_eeprom_init = sienna_cichlid_i2c_control_init,
> +	.i2c_eeprom_fini = sienna_cichlid_i2c_control_fini,
>   	.print_clk_levels = sienna_cichlid_print_clk_levels,
>   	.force_clk_levels = sienna_cichlid_force_clk_levels,
>   	.populate_umd_state_clk = sienna_cichlid_populate_umd_state_clk,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
