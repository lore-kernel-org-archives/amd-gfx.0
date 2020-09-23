Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413F6C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 16:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C33320791
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kins8tLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C33320791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C796E97A;
	Wed, 23 Sep 2020 16:31:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED1D6E97A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 16:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzQOLWD31OTgoLNBc3SBynhke8+DVDPNxSfdD14npD5S9leC5+zJ+JK4OwKevs4j9vHWHyrHeqbEHyzQ0Lw1QGEcS/zcAwc7qptIOVp+a2JEDdCMHza1BbyRmslY/bi5ek2Ia9sMXnxeWmziFi05q55Ecm9fdCCDLUI0O9zFlyw5fQr+9kjm3PDiEqDK+MnrbAHxHBLqgkHq1NRQG8VyQlHLT03SGdvWHJ1pzKVy746Huis2edv9rDanDwdZWyGw8HB5zRgmQUZ7eQhTRrScQHy4Wkm44gFfG/UqXTWvSM6Sh0OuHZ8LlPqd6yZx97xWgw7EtvWt/gWbuj/bhXPvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbOViz2LVa0ulmJJOUXFS6hixSC/qo4fQsmfZ2bi7fg=;
 b=PNXIL+W4+tO6qxBmdh03C+6PAfaXbONofl3/Y1OgdvOHQcDbJFYcgBUb3zLv3NKQhODN2cpDmsI5OhwJ73Mqio5dMKyYYIZMJfSeVPfqAPajXIndA/8xW21ivp4YoOtbF6IptuC1XdE2bC5f6dlGN5wgpYV0X4maj5BtZaHCL7e5HPol2tbz6AckZQ2dzWYn95E6V7HmekbEpv232y4KIfAPhtQwYw44YtdsRM/BhQG5di19Z7EQZ5QGf9iPPkro/PLnP6yxU+sOgB+685EqIIuBJ19Q2i2X9QjMv/5u0y14rlf4/kIv/rx/yG2fmZqm4kTpFfgnV/yCquT35/mfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbOViz2LVa0ulmJJOUXFS6hixSC/qo4fQsmfZ2bi7fg=;
 b=kins8tLDJjuNSxvo6HAvL3Q2+Cty13OA98z4LkLWFBcL5pyYEXDkr+D4J4Dwjnq0DjYuVWOgRR0UX9wfnClq8uTGZZUXIdWHsU/EvImNTh3Ut/ldUcQ54r6XpGKKnK4Aijk+RR2c4LPOrvlSy3o8WRu0Goj232vs5mOMPsNXGgE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 by BYAPR12MB4744.namprd12.prod.outlook.com (2603:10b6:a03:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 16:31:46 +0000
Received: from BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046]) by BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 16:31:46 +0000
Subject: Re: [PATCH v2] Add PP_FEATURE_MASK comments
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200922155500.9239-1-ryan.taylor@amd.com>
 <be88bf11-c18a-f316-9255-1a9d69b76308@amd.com>
From: Ryan Taylor <ryan.taylor@amd.com>
Message-ID: <48257725-d7dc-dc05-eeab-4aef18445d50@amd.com>
Date: Wed, 23 Sep 2020 09:31:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <be88bf11-c18a-f316-9255-1a9d69b76308@amd.com>
Content-Language: en-US
X-Originating-IP: [2600:1700:9260:7260::f]
X-ClientProxiedBy: BN6PR22CA0037.namprd22.prod.outlook.com
 (2603:10b6:404:37::23) To BYAPR12MB3221.namprd12.prod.outlook.com
 (2603:10b6:a03:135::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2600:1700:9260:7260::f] (2600:1700:9260:7260::f) by
 BN6PR22CA0037.namprd22.prod.outlook.com (2603:10b6:404:37::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 16:31:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ecccfd6e-67be-4c15-d398-08d85fde29cc
X-MS-TrafficTypeDiagnostic: BYAPR12MB4744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB47444F189C4A31E7895B48ACEA380@BYAPR12MB4744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDCkAf0dhYoCyKBrTFGoystHFQ0PW2fLy93zREuwETzpMBZJYw9X+HVekOu6p1wcNq168Q4yPFXkcNiD+dV4jXc1DSwElVe/an62MnIdShAL6oP0+z1qRyOY0H86f8aEVSQ7Xf+BPgISv6R4hJGzPoK/HrHwK13+Pjz+Fok4VudHmWrOgXthwAsyZ4he2EvAhMNpcUixJ3txGnLlk1xcGdw1D2dXzF7iUHTK5zY3qH3C575eYvVH44Bp5Gh7PwR1y4vTjTAazF1eVMoA68Y7zrY011UQZ+R/LCc1YKsv+gMZkXeQARfg4mypC8uqqeeT5AekasWfTTlSwus4UgZeyiSrUqdX7eu9DMuGsrCVjIL2z1TwxRl7D17kETTkA0a9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(2616005)(16526019)(4326008)(36756003)(66946007)(8936002)(8676002)(52116002)(31696002)(53546011)(44832011)(66476007)(86362001)(66556008)(186003)(5660300002)(478600001)(316002)(83380400001)(6486002)(2906002)(6666004)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: m0IWUec16f3EALdJXqX+uvKo8jXL/ySfC43kqgehYmVl0rrAljxnb43lPiFZ1do0z519+Oe+NANTMUsiLFjTCIcN7lS0H3VPoIbo8iyn7LK+D3whzOg8g+aNfLR5nHdMxrNjKlXYf2zHFxtQw9F6/BPMIWaRSnnTrFm1AYmKlZWMJsQ/WWWT04+FB4XQZmkW2/aXAMK7niJIyGqzUNRW0VCfRuSdOzmroUrHp3z6KpFknMB/HlZvJ4+yHV3NXx/fTCohfZgsgg5wmQ5Wi2T1VW3FFnu/rPDm+T3GvyhXKzDeZ+gzWqAak74FLieUsKABvED8MZb8k4ZDr2PqZOdvNb2YuZBsxOpHYBOHj6xcNu5jAEnGDX4x9ZWT8btMV1KkqD9roqP9d+AeBOyOYqKecDFRrhgM169WQaDSdGNAm/6G1FFglut6RwdO9I5C9TvWVnXH+NFHViWEbX5nQmUz7GITp8BSYQWCiXMXUMtEPj/HuASRnxkKYEfgs8ejhvxyfSRfZ+sbVvSWptaWCXQ/My3Bd7IXTaUewQAOQvz0flnsbmY6Je5PD2J3E9lxiKeqcbgvVwriavtqb/V8xKJtefxq0by7og5KDnDAIUaTQKZqT+OdxhISke6QCT+C81/vEBqFhxMWbObEhKjQiw2UVWzAVwB24CPI2Csa4F5KQ48=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecccfd6e-67be-4c15-d398-08d85fde29cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 16:31:46.3441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIsuLX9m2RLNwsDBFmHHecTFG3G+GBsO3TWiEqQCwGXSZvaqb9cyGioUeNmUTKKsHVYL340WIbO03C2s2p7yLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4744
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks Luben,

I'll make these revisions and try out Git's patch version setting.

Best,
Ryan

On 9/23/20 7:40 AM, Luben Tuikov wrote:
> On 2020-09-22 11:55, Ryan Taylor wrote:
>> Documents PP_FEATURE_MASK enum.
>> Provides instructions on how to use ppfeaturemasks.
>>
>> v2: Improved enum definitions. Adds kernel command line
>>     parameters to ppfeaturemask instructions.
>>
>> Signed-off-by: Ryan Taylor <ryan.taylor@amd.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/include/amd_shared.h | 28 ++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
>> index e98c84ef206f..7c84d5beb600 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -128,6 +128,34 @@ enum amd_powergating_state {
>>  #define AMD_PG_SUPPORT_ATHUB			(1 << 16)
>>  #define AMD_PG_SUPPORT_JPEG			(1 << 17)
>>  
>> +/**
>> +* enum PP_FEATURE_MASK - Used to mask power play features.
>> +*
>> +* @PP_SCLK_DPM_MASK: Dynamic adjustment of the system (graphics) clock.
>> +* @PP_MCLK_DPM_MASK: Dynamic adjustment of the memory clock.
>> +* @PP_PCIE_DPM_MASK: Dynamic adjustment of PCIE clocks and lanes.
>> +* @PP_SCLK_DEEP_SLEEP_MASK: System (graphics) clock deep sleep.
>> +* @PP_POWER_CONTAINMENT_MASK: Power containment.
>> +* @PP_UVD_HANDSHAKE_MASK: Unified video decoder handshake.
>> +* @PP_SMC_VOLTAGE_CONTROL_MASK: Dynamic voltage control.
>> +* @PP_VBI_TIME_SUPPORT_MASK: Vertical blank interval support.
>> +* @PP_ULV_MASK: Ultra low voltage.
>> +* @PP_ENABLE_GFX_CG_THRU_SMU: SMU control of GFX engine clockgating.
>> +* @PP_CLOCK_STRETCH_MASK: Clock stretching.
>> +* @PP_OD_FUZZY_FAN_CONTROL_MASK: Overdrive fuzzy fan control.
>> +* @PP_SOCCLK_DPM_MASK: Dynamic adjustment of the SoC clock.
>> +* @PP_DCEFCLK_DPM_MASK: Dynamic adjustment of the Display Controller Engine Fabric clock.
>> +* @PP_OVERDRIVE_MASK: Over- and under-clocking support.
>> +* @PP_GFXOFF_MASK: Dynamic graphics engine power control.
>> +* @PP_ACG_MASK: Adaptive clock generator.
>> +* @PP_STUTTER_MODE: Stutter mode.
>> +* @PP_AVFS_MASK: Adaptive voltage and frequency scaling.
>> +*
>> +* To override these settings on boot, append amdgpu.ppfeaturemask=<mask> to
>> +* the kernel's command line parameters. This is usually done through a system's
>> +* boot loader (E.g. GRUB). If manually loading the driver, pass
>> +* ppfeaturemask=<mask> as a modprobe parameter.
>> +*/
> 
> Alignment should be:
> 
> /**
>  *
>  *
>  ...
>  */
> 
> Also, you can use Git's own patch version setting,
> but I've seen here we usually put it in the commit title.
> (Remember, titles do not end with a period.) Something like
> 
> 	Commit title (v2)
> 
> I don't mind using either. Not sure what the direction is
> on this one.
> 
> Regards,
> Luben
> 
>>  enum PP_FEATURE_MASK {
>>  	PP_SCLK_DPM_MASK = 0x1,
>>  	PP_MCLK_DPM_MASK = 0x2,
>>
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
