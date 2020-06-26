Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B6C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 17:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F84207D8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mHaGOTb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F84207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837516E14F;
	Fri, 26 Jun 2020 17:07:12 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690055.outbound.protection.outlook.com [40.107.69.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89216E14F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 17:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my8Umf3+DGVsxVYfNxlQpup6KeMbr5rJfVThLmJsjKIOMuvI/cRfpRNhsssPUMbe5atnpCKRCje/+eszmz31vwCf9tfytetxb2JYW27dHEbfT7uHzoJOSN7Srf1y5iGTWSHsNguiQcSyfr+L6YeisN4nvGLlEMNF+Dp0NdXpyIRGYaOE+/mt5BwOLEiZhmFgV1EBfXdq/EjSsVHk95U3/FP8mmZWIKfprsnydb8RKHF3rlsNq3gqWjLGytQ06uwHOpWxtYx20XdIMlQtz6pk3bt7Njmx+LvyTwN2mrXC4QIIne8P979XXF1JG61ciHy94tY2+lmGbgUls8xXysOV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AxKdUEKD5SgQsA2BRJcAtzc+4eRaEbPRYXibr5Y06A=;
 b=e3lGfCxG0Kn0XInllpXJg3mNi45raWPoaESJ7Cmo6mWGsRu6zDhjV7JzbKlejHlormRcxvAWRqIr5hqNlsXvxLo7havdYs3m7+tY7/0NC1SvQ1mjLrwY+5TY4RkfBnukgpiLZrfu/0tIpNJlyQdaybH6Ai8RBKV6B9qrTUn+H0ipfAn3cvGbgfYEGY1AzdyLqN0bTCiZILbPCLHyXCuBC/cQOzYtH19AWYTnR9cO40Y/8Ccvls0+x4juIkwHDyndKb6gZqTqx4tnGbly2SvUdTe5wvpj9052loCjpHNq2oio31Kfnu1589YdCIYeyGn3EnrXfPIdYi24T9HIYnyuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AxKdUEKD5SgQsA2BRJcAtzc+4eRaEbPRYXibr5Y06A=;
 b=mHaGOTb83AgtIIXzmD5J8ZbQYJ8MrFX094xZ47De4S2KnPGcvWtdYY4cJjQCvwk9rSsMGb3qgx9RZh3KJP+e1TgIAXYHjkEYv4F/odKPvy0Vzs7Q4HfyshNI3lNSSORA5+pobeIvcCDLd/p0A3oRdmfwfDVBRBQTONmtEltoxzw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB3971.namprd12.prod.outlook.com (2603:10b6:a03:1a5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 17:07:08 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6%7]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 17:07:08 +0000
Subject: Re: [PATCH 04/11] drm/amd/display: Handle SMU msg response
To: Alex Deucher <alexdeucher@gmail.com>, Eryk Brol <eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
 <20200626161847.16000-5-eryk.brol@amd.com>
 <CADnq5_ON7hzxmgVEjjhbu6pG5dNHVUMurBzDjhL+1mTiHtMW-Q@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <5879253c-cdc4-b31d-f46c-cf07e2fe9b39@amd.com>
Date: Fri, 26 Jun 2020 13:07:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <CADnq5_ON7hzxmgVEjjhbu6pG5dNHVUMurBzDjhL+1mTiHtMW-Q@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 17:07:06 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14d91c8b-ed50-48ca-baad-08d819f35bc5
X-MS-TrafficTypeDiagnostic: BY5PR12MB3971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3971B3444AB8D47CD0104C24EC930@BY5PR12MB3971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OHWiwnrLRQuPNgJVAkBhrhvwtIw2UGBSy2jhWdON4H4qkhfhgTzOgDOrymsNPmjyISqvy8+toQFzokHMAtY9oMznUgA8zUSNybyx0M3EGyvAOSzzw8MlqQHS3Tng7Dlo+8DlwE7H0eSwULvhAEbVzOlXKbSxa5YI7SwZYegoNQKNvo5FQa7NHUAifG7DNJaBouAQxgDTMyVt7tF2Fi54w/9dND+fHJmdTySLgWrPgOyaHGrZskGAMAmRD5FUv24hD3lFLDvkN0024ChvJKpJI+larExiMuUl8BpBE55hpxrChNEugaOZWS22qdZiszfFrWlQT182UMSBZIumrUfoX/vwU9b9uQdRmqTdgWQCcGTuIc09JwgF4o14nD4ykU+ISQdy9yNprR2/tAkhxeL8ElH/dO+QIaL2AkUG07peZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(110136005)(66556008)(66946007)(66476007)(8676002)(2906002)(6486002)(478600001)(54906003)(19627235002)(36756003)(8936002)(16576012)(186003)(16526019)(6666004)(83380400001)(316002)(2616005)(4326008)(6636002)(31686004)(5660300002)(86362001)(31696002)(966005)(26005)(53546011)(956004)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LFHd7wDW6PuKi5idzWbEIyy+QWaDA0Rsaxi2dsoTgYUgCVeLu4Swl3XdHoh9PVyQYF/olWu6+rUTnyKAW9+6ACI4iEv3jQLWoltaxhuAcSe4Yf4qN4xrau3sdVzQyXn4ogh8TYqL84782C5EsE1HPePSw1hWBNMgZQRdr7J22BmdoI/VsmZRPgAruA2H90UffFpmVBRtV6iBELzlDY7cWwzdO/ewofSDPCcAAJrcZxRVkBcb1ofwNechXWk/+uyJkg6nRyCKiZUSLSOEoCPO9S2d1PnhBMC67E5S/SkskBZe8B6ZoHGgBGN7xzdaZuIyME249JWN4Xjrd9qrNrHcuuZsVuIAStUy8SqRTBC1xFQMb03E/yKJC44Z8BK7ZjanqOsMkeSJ3srItuZNC89xSjF8K+EOkHuiHM1H5o60aHPSvA1CP3PueQSFLuQVzVT8IOsA3d1xN7UPWHuabZJsiugn4/osHhjNGtYJ/6jW33EX5rbiV+F+rTsKGvIYGW+3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d91c8b-ed50-48ca-baad-08d819f35bc5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 17:07:08.2786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NI3jENnKOAe3YEY8y0Nh/ATmrKoc2V1ZbKXUoVsBkeLtxQKIT34bls3WhCTbUUasLHoulkx0LVKJRzKHInDfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3971
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
Cc: "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Yongqiang Sun <yongqiang.sun@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-06-26 12:48 p.m., Alex Deucher wrote:
> On Fri, Jun 26, 2020 at 12:19 PM Eryk Brol <eryk.brol@amd.com> wrote:
>>
>> From: Yongqiang Sun <yongqiang.sun@amd.com>
>>
>> [Why]
>> SMU may return error code to driver, but driver only check if response
>> is OK.
>>
>> [How]
>> Check SMU response instead of reg_wait, assert in case of reponse isn't
>> OK.
> 
> Will you ever get concurrent calls to these interfaces or do you
> already have a higher level lock to prevent that?  You need to make
> sure you don't have multiple threads using these interfaces at the
> same time or you'll need locking to protect the message, param, and
> response registers.
> 
> Alex

IIRC this is a dedicated message port for DCN. I think DC locking 
prevents this from happening on the software side and HW/firmware has a 
different port.

Regards,
Nicholas Kazlauskas

> 
>>
>> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
>> Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
>> Acked-by: Eryk Brol <eryk.brol@amd.com>
>> ---
>>   .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  | 39 +++++++++++++++++-
>>   .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 40 ++++++++++++++++++-
>>   2 files changed, 75 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
>> index c320b7af7d34..dbc7cde00433 100644
>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
>> @@ -26,6 +26,7 @@
>>   #include "core_types.h"
>>   #include "clk_mgr_internal.h"
>>   #include "reg_helper.h"
>> +#include <linux/delay.h>
>>
>>   #define MAX_INSTANCE   5
>>   #define MAX_SEGMENT            5
>> @@ -68,10 +69,42 @@ static const struct IP_BASE MP1_BASE  = { { { { 0x00016000, 0, 0, 0, 0 } },
>>   #define VBIOSSMC_MSG_SetDispclkFreq           0x4
>>   #define VBIOSSMC_MSG_SetDprefclkFreq          0x5
>>
>> +#define VBIOSSMC_Status_BUSY                      0x0
>> +#define VBIOSSMC_Result_OK                        0x1
>> +#define VBIOSSMC_Result_Failed                    0xFF
>> +#define VBIOSSMC_Result_UnknownCmd                0xFE
>> +#define VBIOSSMC_Result_CmdRejectedPrereq         0xFD
>> +#define VBIOSSMC_Result_CmdRejectedBusy           0xFC
>> +
>> +/*
>> + * Function to be used instead of REG_WAIT macro because the wait ends when
>> + * the register is NOT EQUAL to zero, and because the translation in msg_if.h
>> + * won't work with REG_WAIT.
>> + */
>> +static uint32_t rv1_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
>> +{
>> +       uint32_t res_val = VBIOSSMC_Status_BUSY;
>> +
>> +       do {
>> +               res_val = REG_READ(MP1_SMN_C2PMSG_91);
>> +               if (res_val != VBIOSSMC_Status_BUSY)
>> +                       break;
>> +
>> +               if (delay_us >= 1000)
>> +                       msleep(delay_us/1000);
>> +               else if (delay_us > 0)
>> +                       udelay(delay_us);
>> +       } while (max_retries--);
>> +
>> +       return res_val;
>> +}
>> +
>>   int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
>>   {
>> +       uint32_t result;
>> +
>>          /* First clear response register */
>> -       REG_WRITE(MP1_SMN_C2PMSG_91, 0);
>> +       REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
>>
>>          /* Set the parameter register for the SMU message, unit is Mhz */
>>          REG_WRITE(MP1_SMN_C2PMSG_83, param);
>> @@ -79,7 +112,9 @@ int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned
>>          /* Trigger the message transaction by writing the message ID */
>>          REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
>>
>> -       REG_WAIT(MP1_SMN_C2PMSG_91, CONTENT, 1, 10, 200000);
>> +       result = rv1_smu_wait_for_response(clk_mgr, 10, 1000);
>> +
>> +       ASSERT(result == VBIOSSMC_Result_OK);
>>
>>          /* Actual dispclk set is returned in the parameter register */
>>          return REG_READ(MP1_SMN_C2PMSG_83);
>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
>> index 6878aedf1d3e..d2facbb114d3 100644
>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
>> @@ -26,6 +26,7 @@
>>   #include "core_types.h"
>>   #include "clk_mgr_internal.h"
>>   #include "reg_helper.h"
>> +#include <linux/delay.h>
>>
>>   #include "renoir_ip_offset.h"
>>
>> @@ -53,10 +54,43 @@
>>   #define VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown 0xD
>>   #define VBIOSSMC_MSG_UpdatePmeRestore                    0xE
>>
>> +#define VBIOSSMC_Status_BUSY                      0x0
>> +#define VBIOSSMC_Result_OK                        0x1
>> +#define VBIOSSMC_Result_Failed                    0xFF
>> +#define VBIOSSMC_Result_UnknownCmd                0xFE
>> +#define VBIOSSMC_Result_CmdRejectedPrereq         0xFD
>> +#define VBIOSSMC_Result_CmdRejectedBusy           0xFC
>> +
>> +/*
>> + * Function to be used instead of REG_WAIT macro because the wait ends when
>> + * the register is NOT EQUAL to zero, and because the translation in msg_if.h
>> + * won't work with REG_WAIT.
>> + */
>> +static uint32_t rn_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
>> +{
>> +       uint32_t res_val = VBIOSSMC_Status_BUSY;
>> +
>> +       do {
>> +               res_val = REG_READ(MP1_SMN_C2PMSG_91);
>> +               if (res_val != VBIOSSMC_Status_BUSY)
>> +                       break;
>> +
>> +               if (delay_us >= 1000)
>> +                       msleep(delay_us/1000);
>> +               else if (delay_us > 0)
>> +                       udelay(delay_us);
>> +       } while (max_retries--);
>> +
>> +       return res_val;
>> +}
>> +
>> +
>>   int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
>>   {
>> +       uint32_t result;
>> +
>>          /* First clear response register */
>> -       REG_WRITE(MP1_SMN_C2PMSG_91, 0);
>> +       REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
>>
>>          /* Set the parameter register for the SMU message, unit is Mhz */
>>          REG_WRITE(MP1_SMN_C2PMSG_83, param);
>> @@ -64,7 +98,9 @@ int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned
>>          /* Trigger the message transaction by writing the message ID */
>>          REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
>>
>> -       REG_WAIT(MP1_SMN_C2PMSG_91, CONTENT, 1, 10, 200000);
>> +       result = rn_smu_wait_for_response(clk_mgr, 10, 1000);
>> +
>> +       ASSERT(result == VBIOSSMC_Result_OK);
>>
>>          /* Actual dispclk set is returned in the parameter register */
>>          return REG_READ(MP1_SMN_C2PMSG_83);
>> --
>> 2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
