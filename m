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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC0DC433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2902073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="afpmPez2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2902073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B53F6E156;
	Tue, 21 Jul 2020 17:01:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8676E156
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 17:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgYR2zuyAj1rO92zB67qc09sFzUnZT46SjnRCiD6Y8iWSZbXTD9LLqZnDZ57IggqK79L5wl/T/1uQpRhiViGLAVkfs7bCbD6aaYwFuEQpYJFl6/2kLMmoOBSF3GJi6DvLso5uVimOTOQKWDmE8lpc4V/2xZpCxmAl7TxPK9rIbA5hy6mJvQjFusmilstbhiQ1zB07CcriSTVLHfCUseySWZeRM8hms+N0UlyfQscwqYUlGm9DmySpWYm8qnc9m79TXC5EWuWAvLlXgtLjyvE9jaKyF0jk9V2UUz8Upk0X5/QwLOt4VORXT7yW4LkHYQ0OYTGPjWOt5X3j8UpqFqxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TEdWLNeZl+JUjylz3Z5t1F3fc0UIog58x0CT61dk9o=;
 b=P7Ikj92JVct7vUXg3W8nnPnwz2lRKLpojsQIt63+vX6Kds/9Wff/0l7Bvo86UGCSUmakCtCEEU7oa9Wu9pH8dkvRxS9Y/JsIIzA58LLlJfrZG7MNHtkwLz6/H0WWuMlJFCKHMKmOpa/SUXnttQxC+ON7nksgGCO+B7YEJe7q3JD8vA9kSGKxETPAfcrhQEjLsw/Q2C0GHdleTfmmDxKu++RWq0KS13QBClaH4TLn6UVhow/dP4piP/oL6Qiifj9nhmD9SG7sfq8YitGZvF19C30mZQSKL4m2ZqdbyEHXTSeIdxz19L7xDJoYJ1zIlQBSL83mOqUAYd9TZS83HveIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TEdWLNeZl+JUjylz3Z5t1F3fc0UIog58x0CT61dk9o=;
 b=afpmPez2wuitADhYWQpla1PlxAnU8psj7jSzdYo1A+DSo/tg9WsA3PiwQEf/jDZlwhU7f+xkZBVwqcfAfs6XZm/kRlNzDA85TSS/j4axm6GA1/B+0E6PDjPSmMi8u8GsksaVWOnIQgUouFDYn9McoK4zMJ/jGrPhZHmLbZMlzWA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20; Tue, 21 Jul 2020 17:01:31 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%4]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 17:01:31 +0000
Subject: Re: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c support
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200721165240.296265-1-alexander.deucher@amd.com>
 <20200721165240.296265-6-alexander.deucher@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <fa57d3dd-f945-1407-b813-170be1cbfa0a@amd.com>
Date: Tue, 21 Jul 2020 13:01:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200721165240.296265-6-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN7PR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:408:34::31) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:646c:e41c:908f:f19b]
 (2607:fea8:3edf:49b0:646c:e41c:908f:f19b) by
 BN7PR06CA0054.namprd06.prod.outlook.com (2603:10b6:408:34::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 17:01:30 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:646c:e41c:908f:f19b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 820d9f55-eeb9-4d01-8466-08d82d97b766
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0105227CD5A0A2542D9A6FC7EA780@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARRSY3ewrtNSemmbD53iwj8/Rog+4vHQUnJdpErVB6kcFq88fdRGL6RMuDhoOsm3boZmmaWXDYq8eKGqQoxLqWeuwREp4neZBwlvjNivtatEd3KwH4yqOlWRhcjnPN02pKg6LrAJCTdkVDBEIE59XL8jHiOFiNghE5fZ2JtoEJ5+jx1z+5cs+DIiaPofnY0G2C0KMojQavtjNe6D4HIDQzeZpDENjmREHbGHTmesUrUFRatOlwOqM4HN4EZz8H/uW5RHk2UkKDMT4Yvn+6+lJRaiQFywMFnMXfPJOS5VhKDGbj3DrBx8jashQ4+w91jtZpforOSTVFOXYAjgZP6EbPc/PL8LFGnZmytHJ43ROh+Y3aMV+sxC1cMlLTyuy0F5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(8676002)(478600001)(36756003)(186003)(31686004)(66556008)(6486002)(53546011)(66476007)(52116002)(83380400001)(66946007)(16526019)(8936002)(5660300002)(4326008)(2906002)(86362001)(31696002)(316002)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: C4/6dhOrdQaxZGvR47Q5ysi2r4Cy4LOfmy2b9TlkLBxtehxQfKsw1QNefv20F5D8PL+oLFg2SnWTYzjlihbpLYVyMKzg0bIMe1sVLJMuKDllav1WhDqIzge9Z1XqfnmRcwEpAtRaus9aiosoVVOKx5MpXAtUEmpE90vLjZYUNl9cEKf6S25McC8GCt1DI90sY+ESbyBxXpGBl8aqGkSf/ja89BM6q8Og2qwFIzzXNESJk+6bXS6aXoCAq+m+ttmVbRrBs+jtt8iUPLtIjBv/kOx1DLajpKnKrXtzr5H1Xt6T6uPZb7Pex1rKzLquuLXx7bRrnO9NLWFzcuk9EO39zaHoFoe3ZbNwPCXp+z1yauazIJ1YUV+zKiqwLMhEuX+6v7/sotqDSy4K1F9bW4bQXIj5UTpYAfAMyTvfknJSVfhfKG9sFTg04u416tmbDZ/DD6V+r44Go69I/SqNzZP7pwhyFhq5CnKijtJwkrsljDqEBA0f0/xQw4Yl/UIoa6IOg+g9OYy9sQKnsU3jwNuCLSAQ3QGUScYq49u81peZk6RJ12waRbZ1NPDVUCq0Eqts
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820d9f55-eeb9-4d01-8466-08d82d97b766
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 17:01:31.6590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgWoOrbabYz9v02bU839n9QB0YaIpx4n4SScDukDh/QCCe/RwIjsLSr230MaL+D/8LVzt1yG5yq8L+SGlG+BTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
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

Looks like same code as arcturus - should we make it common helper code and 
reuse in both ?

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
> +		/* Add STOP in the end */172.31.4.187
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
