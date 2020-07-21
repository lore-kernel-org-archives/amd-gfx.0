Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00863C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B630020720
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0IdMHTtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B630020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E676E10E;
	Tue, 21 Jul 2020 18:14:12 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7786E10E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzcDlrpZyZar4s7ZcidXf8qzEFrXQB31hnXbt2IMWrmMTKK7DVW/7B+r+P/e+sbjdf6aJ6hEmsN3PTGKPbV75618mpgkyzC/2FXC0g1eWkwde4pmAJpOdu0N4X3c32Oz8t7PEMw5yhCaQ01DlTOD3EGgpfaYDTtZxc9p3P9DO+L0W6tmdj3JL2tIgJP1z9vXpq3aY9V0X3hpmby6feWU7AyfZYkd78oX3ukF2iG+S/Mw8TpS61HL0RhXa5u++KC0EUO+yE1SJIl6c2IhJuwilx2INc8+iK9235aYVt8pobpm0PsFBqjBiOwtDnDvfQ+U54JAitDK6xgib68MAFTCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJYga1IKUsYybVjRREMDpJpFR56PKtPqnNEAujziIK4=;
 b=O/e/0cLzgMHkfeDWAUNt4CN5GhKI057oEVacaGL3IxwtNw2IrjHL5U1m+f9KvqHzftP8oHPf+y5yV/gqomQZy6u/WkXJc+YMF1+e07jrnhF4Qp5p2XRN25AkSggaM6PCjHVFQWaaYgHAglgfRhemSAM4GrA2FwrGqE+2i1X7ZG5EXnGxtQ+ABzSHYMyc6VZwTu/QqKZJbk/6e1V9ggVCNTw5Pg8wvCnWLfWxEbgWH6IxOownoRcv1jlhetbPmjrUucKcUWxx6rN6leGjsJeTw0tOHfg8hRXGnjwMS6SIhtYeNpx/0CRt9AdjTFcOdRSZdQGzDwUSXTaoATtIrCYubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJYga1IKUsYybVjRREMDpJpFR56PKtPqnNEAujziIK4=;
 b=0IdMHTtrTiHps9cHrU7O7dhUQ0lo69HAlHymATcK9wKwevlui2P4qpglffV/BwRsSxdItG+ttXKj7nAa3N7mQH5tydZRA6OdG972NB2Nh3YePiv1/5AxY+/r0RvUrM5XMa1n0lKRR54MZ97R8MwMmeZonwYAwQGuW8ZvNiHiHD0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Tue, 21 Jul 2020 18:14:08 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%4]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 18:14:08 +0000
Subject: Re: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c support (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200721180850.813406-1-alexander.deucher@amd.com>
 <20200721180850.813406-6-alexander.deucher@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <66a02fbd-7416-6911-7303-c8f7104c6b8f@amd.com>
Date: Tue, 21 Jul 2020 14:14:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200721180850.813406-6-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:404:4c::19) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:646c:e41c:908f:f19b]
 (2607:fea8:3edf:49b0:646c:e41c:908f:f19b) by
 BN6PR03CA0057.namprd03.prod.outlook.com (2603:10b6:404:4c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Tue, 21 Jul 2020 18:14:08 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:646c:e41c:908f:f19b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d06aece-f49f-47e1-69b7-08d82da1dc96
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2582D489C7CF4B622F50EE55EA780@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: if5jeJqBXMIQFNAUzt/SDUnGCHDypSc3Vpu7siKbSWEYeN/OvOROwJZaIZF1zr75mHHF9CENBQgklEMqbURfgfUd1S0fCcLVx+2kOjB3nAalPt4jpdKI9HHyBBjwXObGM0ZcRQFBinJV9HfTOCodnh0bMgw7KZJOSd0tDtTM1Ol9ScVgVVZ/V9U5SmwoHgNdf5VFMGz7de1pn0QB19GA5kG9dBXfRmP+f4EjnHJU7Sr1rpzqSlWhiO1uqdjDZnf7k4mT0JIACkMdpAmkWJ5EcfGW4y7uImD5ZfetpUaDtXW3WP7Yhrz9pXy8c3yqn+KEZFxcMmzVcJx84xpazM2L8ZAHpqzcZEneAG/GlDROh5dFuGU+gH+JtFIMFcgsLrfC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(8936002)(6666004)(31696002)(5660300002)(316002)(4326008)(66946007)(53546011)(83380400001)(6486002)(86362001)(8676002)(2906002)(36756003)(66476007)(66556008)(16526019)(186003)(2616005)(52116002)(478600001)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dgPFe8V+jtkvBPKvCDn6YelsOhjMZjNCRtI7yCysbuG+CCPYfZQSxskEZxqXzAxnOPcUFkv2qoWM2q2igo7kCT7Sy6aY/8s1NjCvbFMKRJd+F0LNqjl2lP5/BHaRiodT63LmgSE5qtRL2di1dMi3zzdSQgcRGA/KhlkD2TD7QIfiPRmPRJieAJNYMvr087oVh7RLd/LNWrL+g+x66SYg79+Y/tSFpz1r6XJi2M0/vuFbw4Xgma0PZCVKfy1oa9lQjN3wMebbOsrtjNUPBGYt+sZDcK6eDhzjXbVjItgbpK12wx1HZlLGq5d20DBYJZxH6qvLCuGWqjNw9PP5sdSMjgbO9NcT9ri2rzmQNLoltYw7/lkmi8JFPiR2Ocr9Hc32VQEZeys0kLsOxhkqAV/r+JaClcVZ07UruOo7bFlJJk9oRxu/FxOqsyh8tXT19iSaYeYaWJAlRscZ8hTwY4BPc8CJLi+sYZGu7Og6HNiD8JO9/ZsQnd4K1QdQvfCZYxHeUwV5+bwdtLPn+vMyxOkP3q7EioIrYcgOjKIGDZ+vF2EyBkXlrvWycDFBFtVJ1qUQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d06aece-f49f-47e1-69b7-08d82da1dc96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 18:14:08.7944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1U3FDpfFjfxJSrWIwvTSX9QqeJzzu7w4xll7IrovAaVdMsARPB0xghX3sSxnG7U3b1N/yY6kstiliP8w35cig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
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

Series is Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 7/21/20 2:08 PM, Alex Deucher wrote:
> Enable SMU i2c bus access for sienna_cichlid asics.
>
> v2: change callback name
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 239 ++++++++++++++++++
>   1 file changed, 239 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 5faef41b63a3..2438751359e7 100644
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
> +	.i2c_init = sienna_cichlid_i2c_control_init,
> +	.i2c_fini = sienna_cichlid_i2c_control_fini,
>   	.print_clk_levels = sienna_cichlid_print_clk_levels,
>   	.force_clk_levels = sienna_cichlid_force_clk_levels,
>   	.populate_umd_state_clk = sienna_cichlid_populate_umd_state_clk,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
