Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A69C4320E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8ED60E0B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD8ED60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C93E6E841;
	Thu, 26 Aug 2021 12:51:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25B76E840
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFakFPIx7NWu0LD1q9t4xsXGh7RmQiWnDaLmIIQRp8kUCAeUVxO7IjCT7/KvmsoI927ZnxER6NrJuWku0lZWtGcLpCMePrKwl7AxBrUDzBe2A+JkR5o9OJ4FRU1ERjRUWiyRs31Wv9tBx3RejodBIeZx7PkY7+ZnwW0N6FDXF8BBBhOtTrwhXYGeR8VeZP4dJy1n+JlzP0kcvIUKklouTvdIWLto+Q4vlJj7xZ0CAjiBzLvDLB1zye6YF0la5eeQHofUujLwNNRuPR95E0bDXy+038DVA6mr1XnE8MIiTJVR2vntiJBuIxEtNChx8o/BVMI2ltmcdAzzvmgXiCZ4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voptNexezWFCzrUTs9Gp29vOGb2jMsQTea2gqQG2ecg=;
 b=YmLZGCNoH2akY4I+XQbQJw2VqhJiSvMLiPQTSDykwuUU74t64n28GDaF7pnogX0wDld7/oWv5MnLj/+6q0W2Xt6FYJhm3PHt315VBZeOBBUSpbMqXqGfFM+SoCF6PLc+xls3XrGAmpRgSmHUqthh26gybK5++ApwqyIE1Y1ZX3nRQe4pqS5iLCUZJYbv/wMKm2BT1Fj+Tm5RMdVvmv8q1IYzwogY2miww5i3jG7+f2JUiwZme7edsXjiUX85RDWGymDgDwNnnwdWJVAYtU+iGick7rS1nN6MfcYS6YaazdoKSppRnml/tMd2j/FKA/s8Yi6y+fk7aqlLK46QxcAv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voptNexezWFCzrUTs9Gp29vOGb2jMsQTea2gqQG2ecg=;
 b=pi+dszNUcej7+GzSRwGO4tGEONYRtnJ+4Be0Wo2FzHEVHG4RX7uv01DPGsuw1HArLt2rR5Wzvg2lyzZbKNTB0Z/NYOvf27zEV4p0Ag0/WgB4ErWKdY48Jd+QkM5tWV9O1GSZNcz6bpeVqwDgbqCHRq2IuPEhmIWcFS3u6cChceM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 12:51:26 +0000
Received: from BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7]) by BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7%7]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 12:51:26 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu:schedule vce/vcn encode based on priority
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 shashank.sharma@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-5-satyajit.sahu@amd.com>
 <e36f4512-3025-6abc-3afb-27d26e102be9@amd.com>
From: "Sahu, Satyajit" <satyajit.sahu@amd.com>
Message-ID: <bb48216b-c6bd-6f64-dcd9-397eafe5ca26@amd.com>
Date: Thu, 26 Aug 2021 18:21:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <e36f4512-3025-6abc-3afb-27d26e102be9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN1PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::19) To BN9PR12MB5035.namprd12.prod.outlook.com
 (2603:10b6:408:134::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.254.217] (165.204.158.249) by
 PN1PR01CA0079.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19 via Frontend Transport; Thu, 26 Aug 2021 12:51:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3bacac6-3dd3-45c2-efe8-08d968903737
X-MS-TrafficTypeDiagnostic: BN9PR12MB5035:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50351EB14187F85542CF64F6F5C79@BN9PR12MB5035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLoE2EkxVRD+ZLy6xiYlPPDKF2jSOoIomOGMiQtpRCsrqKV+bFr9o5PpHPBVRfgutzULUmR0HEnwocFqewtnbbLfHBPuJ5XPxJWtRFPPKF5cmZ7wdBkife42mGx4Al+gVPsZaGGwEIBwLEhAV3NgoCTfl/7C3bq5g15TdAz/UJ85n3Ngth7aWN1D0DAANzlyaM3qaRlqdlYMZuhcGMWY5oWTpXQfFPiqmrFRTKaVdI5Pi6N+JDmqsWpffH8unDPNxNBoMKjEbY/aRi7aHR7fwFkb9qZb3GDy+gJuCAJ+b0pES9dMqtx9LhNES4OenOBY43LRiTLyzLegfkL7eDxUcLkVLkVrPa2gaTcVutXOI8xbNw84ZDOwehNow8Z/McbT2nffHWj4Na8UWYVTwYM1HzUrYeGIl72s/NG45JfO/xdLAIT9ACHHUYpqUIhZkLCvENC7DFu6+enctcadmO1aME4eTBjQQwGSb4Qi7UzufW2Upret16HjiOfXB+jZPwLTjYz6cDxlXUKEkYZrTGUw9rmwsrY2OqV0WrBp/lf3AQbo8xO29GyX4iS6Bea+t8utJWsjf9clRhmAvUj/GFBR370US3CfojUG9T0sLd5C2ZNrKuMus8IOAsw78P+u5mLjtNfClL5mJISuda9VeWCHtmS0jq85MQWwPuMG6u9W9RsU2rX5FrstvUVnRd36QDdA6cnNM+Bl1Qp5P9Y/+MReBT1sCCtuyAXeyI8Rt0qE3+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(16576012)(956004)(31686004)(86362001)(2616005)(31696002)(5660300002)(8676002)(38100700002)(2906002)(66946007)(66556008)(66476007)(4326008)(36756003)(8936002)(26005)(6666004)(186003)(316002)(6486002)(53546011)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG9RWmU5S2wrVlB2b04wOGpLeEw0NXBXd2xDaWZRQmtkak1ZSzhidEZoSzFj?=
 =?utf-8?B?MVVxa2xQY0NtcGh3TFY3akh1QnVET0VjMmdsTFNqZVJjemVFQUJheW1TeXc0?=
 =?utf-8?B?cjRFYXY3WFRsemNScS93Z1VpZU1PS24vZkdBVVRpaC8zWG1BOEJPWHdRM0FB?=
 =?utf-8?B?WlJhYXJib2RtaCtMMWZrUXBSY2VUd3pJaGRtcXV3M0IyVzMyU2E2QmU1T25V?=
 =?utf-8?B?dysydWJDbytPc2hWaTJpeHUxeFVlSzBQNzdwTnZPRHdYV0pLcVM0NytBZ0s2?=
 =?utf-8?B?TkhzSC85bWdJaUxWblNObGpaWGM4eXN3eHJFdWRuM0lDTTQ4YitXMkNZUFli?=
 =?utf-8?B?NE40OFgrd1BDY0VKSjBEdGVDTCtOU3ZScVZNRGg2ZFNFMnQ4Q2p4VER4YitN?=
 =?utf-8?B?Wm1YamRkaVpQRkhNQU14ZktuSUpFNVRnQUN0ZGRKQ1d3Y1p3bmJtN2NkQnFt?=
 =?utf-8?B?THB4bjVQbUl5TFB2dWhnY1pueHNHdlNBekFmUXQ4aWR3dnlITDNNbFFHRTF2?=
 =?utf-8?B?NHdRMDRYUllUK3VqOTNndkU1WnZhNCs5ZUJmNkg5bldzQnl2Q2hhcTZ3RGhR?=
 =?utf-8?B?QnM1Q20xY2VIVlFicTBZT0Y1NnAwdmEvMW9TcFQzemVMRzZnaGRreFV6TDhm?=
 =?utf-8?B?ZmRIQTRaeFhxd1g2TUtpdjhKRmptdXJLQUp4MCt5RFplemxHOEFEeWZsdEFU?=
 =?utf-8?B?eHJITVhjSkt3aGlyTCtISUFwRjRKZmYwd0tSeURBcktxeWVzMnRYY2NsMzc2?=
 =?utf-8?B?SWxoRC9rOG9SNVl5enZlbjFiZmVKTk4rU0xlMzRmZGlmR3NJRDMycUNQYnEw?=
 =?utf-8?B?ZWVPbDRIdHBxYXc3eno2N3p3K0V5Q3Z3QVkxTUtiUnU3Y3FrZmY2aWExenhO?=
 =?utf-8?B?d2VUeGdYZElKOVBXVGVyWUdsaUJleDhQVEp1THIrb2RYM05lZHMvMHZrWHdG?=
 =?utf-8?B?eVBXWUwzODhtbGcrZk8vWVNrRjZ2U2cvT1FBbURyNi9PUWU2bi9ITUZ1UFM3?=
 =?utf-8?B?WCt1eG1MU3ZmSFRmaURaemVnRERpaHBENEZNb1VjemYzWTBNenpROFZHaTZR?=
 =?utf-8?B?N2FBVWhqWFp3MjNpc2hRMHNDVmw3RWVDUDB2MVBwSjN4UXVNTEc3MGNVbjVx?=
 =?utf-8?B?WlFwUkVuVCtjL3ZGZ0pwc2lLV1VKUjZBazZlQXNnQTVicCt1anRTaUhGdk1H?=
 =?utf-8?B?M1ROeUhZeDk1TnpGU1ZIZ0xwUThqVVFmSHZtRHZYaU4xREpqTTNOYTRFR2c5?=
 =?utf-8?B?QXRhT0Z6UU9VdXMyczZjVmdmQVNsL0doa2dPdHl0YUNPK0RnTTVrTlBsbkdx?=
 =?utf-8?B?K3ZTNFpOSXZqWVZwNjRkYnVTY1hhZnNJSUVVeCszKzE3MWNOU3BmcEg5VVg0?=
 =?utf-8?B?Sy9xNk00bmZ2d2ZHWUhrWE90Tm92VFFNMjA4VnlIdmJrd1doeWVCV1NQWTBE?=
 =?utf-8?B?QmdGT3hzYVo4R0xPSWlXekFFUisvUitUWHFRcVd3TGlwRlBMaWlSa0gxWFBi?=
 =?utf-8?B?akFWK1hwY1Z2bnpmZkZOK2QzOFo1c1NuV1B3VHhQMFo1Z2g2bXdjdVdBK0tm?=
 =?utf-8?B?QVhGYTh0bmRWWlBtSDhtZVVWSEl0bHNUNG1UOGpuc0gwQWRRZ1BXTTF6V3Bp?=
 =?utf-8?B?d1plMkQ4NVlYM29zUTNkZjNKOC9zVk1VYmcyaGVBSWRONFZMMG80dVUxTWU3?=
 =?utf-8?B?OHZvRXpHNlEwV0VJeXcwZ3hVS1ZzZ3UyVEh4amI3UnVpK0N2R1Z5VGpmWVg1?=
 =?utf-8?Q?6+8RqxzeOhyUTWAqfngPhQGnG9chAhMPezBQ7q3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bacac6-3dd3-45c2-efe8-08d968903737
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:51:26.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzgejKAu+quV/jPzLYBvBo/tbz1PTOYl5cjMdD4TezNdoBdKl+Ia3s62q9bNx3LN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/26/2021 5:31 PM, Lazar, Lijo wrote:
>
>
> On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
>> Schedule the encode job in VCE/VCN encode ring
>> based on the priority set by UMD.
>>
>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index c88c5c6c54a2..4e6e4b6ea471 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -120,6 +120,30 @@ static enum gfx_pipe_priority 
>> amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>>       }
>>   }
>>   +static enum gfx_pipe_priority 
>> amdgpu_ctx_sched_prio_to_vce_prio(int32_t prio)
>
> Well, there it is..enum gfx_pipe_priority. I really thought there is 
> some type check protection from compiler, looks like implicit 
> conversion from integral type.
>
> Thanks,
> Lijo
>
Will change the return type to amdgpu_ring_priority_level in v2 based on 
the Nirmoy's patch.

regards,

Satyajit

>> +{
>> +    switch (prio) {
>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> +
>> +static enum gfx_pipe_priority 
>> amdgpu_ctx_sched_prio_to_vcn_prio(int32_t prio)
>> +{
>> +    switch (prio) {
>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> +
>>   static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, 
>> u32 hw_ip)
>>   {
>>       struct amdgpu_device *adev = ctx->adev;
>> @@ -133,6 +157,12 @@ static unsigned int 
>> amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>>       case AMDGPU_HW_IP_COMPUTE:
>>           hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>>           break;
>> +    case AMDGPU_HW_IP_VCE:
>> +        hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(ctx_prio);
>> +        break;
>> +    case AMDGPU_HW_IP_VCN_ENC:
>> +        hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(ctx_prio);
>> +        break;
>>       default:
>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>           break;
>>
