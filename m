Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD2C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C5E60FC4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53C5E60FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB45888C11;
	Wed, 11 Aug 2021 09:47:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F68C88C11
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 09:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imnbMjlUamrwUXZQxJBQc6+GYFoLXX+kFHjlAqekPK5bsJU8qyBUuAzdIaaRpzY/hwAJUfHzCZe+sZVA9gcIg1aGWPvcgYmwgIWx+bbOHYd2tD28iGlFrvZKa5skHJ9q0ykBzupXHK2jarc4zjOcl9cRugJ+prssQ51uXuw2q6BmpgfvYW2/JSml/X/wSDN5mzM7UC5J73YKWxSY1vvCnXdLuoQu9byn5M2PlS9z9h+5eXovRdJ+x15CMQxN/JXK06+EHVM3x9qqC4FmmCzDEjbWO3ycYxVj2KTorNyNEw4B91nBzefEeTYsJ9UFH73t57Qh86U3m00Nv6E21EfvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGK//6T+ot8sdt7IpK6KZb2AxFbMpgqhJik74UCHDB4=;
 b=eRYaVOVe4VoplJ8CelNddLmKKZgnRAzI/V0SxpJ2NZxWoGriLSRI5+vCIg5oyXfQLuO30iJUgNkJOrF8EgmufZh4oUu5Wx8kEh4uuztZkP012WEHp0Rv/zzwRkrLaG39sFA5dHDZs04cRrdpRvGoZ19enIKe5gNVph3wzefAqC9jZnrIFjIzfjFihNYMR1ExqHdNHoCAfpHUT8i8jaUbPIs+2YkWNxrSJ7JNwbpPMZrU//KdC23+Sx8FSkt7RKqdx7LUXMd+fmybCfYi0ikPndWrOeO2zJ35C22wl29Pyct0Nc21KfghuhvU3d2wljUsczu3xxT7kRF+KhKIj/KQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGK//6T+ot8sdt7IpK6KZb2AxFbMpgqhJik74UCHDB4=;
 b=YpSf4oI9G7qe1nyk22aqNucUHrDMC20QK0mINavOQufjfcKt2wHyZrimY0QbG5hTnaew+ZbnLhHB2b2ntgL2vr+8+mBsRGaS+67vtJSNst2nMXgQWX/faWUNrnpvq/OOzq4Dv7Mfe67F8t1NuJLASCPwU6uIjxVHI+GOHh8o0eg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Wed, 11 Aug
 2021 09:47:15 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 09:47:15 +0000
Subject: Re: [PATCH 3/5] drm/amd/pm: change smu msg's attribute to allow
 working under sriov
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, frank.min@amd.com, hawking.zhang@amd.com
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
 <20210811083323.1084225-3-kevin1.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <0b1559c1-b405-ff30-b310-324610604ee4@amd.com>
Date: Wed, 11 Aug 2021 15:17:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210811083323.1084225-3-kevin1.wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::24) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0139.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 09:47:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7242b80-80c2-4e45-0f23-08d95cacffd9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5207FE9FC41C44E20A8C281897F89@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aJI5aAneOC5s6QFNRgM1rxYLdu4q/bSBaeQNI3oOC5MDZu/h/M2+qQDPHHvkMKriw/ZU8FH06bXIPp4eQ4UQ4ovQXx/jhNX6u7kH4sOPpcPg0AAd25f7GmaaF8MnswMyJOMx7/LtCr/RbpbVmgz6OIZ+cLJXWktkQatXp+S651x8ww1U5uGLawKH30mSxVJnHin+tl3KNIDgQeq4p9yfPsJwA8HDTspKfYPYlwZKjUkWlh2GRSIJjxitCnbl7zz0N8YZfzE6/9fSgrf3NrkX9e6dwIneHXZFdgDPE4F+IXS4lfKopWpSLCqU7cNiRrPJyz1EN3ucdxzA7BPQmEMh1S491c52LAEDMCahIJrN0NRQfYUW8bdHkj0YZ1FoEDSwbQ0zacIGeNdzdprkOemk/sEjVCEZ2Wi0xK2V51+XnTnkqiKe2a7CdSJDb0RwtwC1bCcEEPOSUIiwsWNX2WZf0Lc7X8gII8qBRk8y1evCG0lo2Ybl9nVeXsOnWACEdvY79sElPrazlMHpOQOHilxFyQFJv5fTL9mlYxAgSyWNqIj2dBW+sPZmOdeUgctsHWdJoDEcit9a6mQSdev/pcabJu6caSJGesyCH7Gomkijh6ltRUZj6kLexvGfMEP4TclgD2gyYhzKRYJii9nYN3lF2HNQS7/zkKqzSAUvXgJKiI7PfP8aVnAY+KXvpKiSErafNyej42kRNIt6p6zfzMjNLD7XCsQRAvOCTtSTkWZc2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(8936002)(6486002)(53546011)(316002)(5660300002)(478600001)(31696002)(16576012)(6666004)(8676002)(83380400001)(186003)(4326008)(66476007)(66946007)(26005)(31686004)(86362001)(956004)(2616005)(36756003)(66556008)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpCYTlzbCtRNmZ2Q2hxY1BpV1Fhb0lBT2dkU2R0ZmVVLzNraFg3OCtXZERn?=
 =?utf-8?B?WkRqclo0ZzROenhCbXVJblUzTTQ0N0Znd05aczV3b2RSVUsvR1dnWjEvbnFl?=
 =?utf-8?B?WjZLck0zVXVDWXVGWXhRL0EvS1N4VUlYY2hPUkYvN0MvZzR5MHU5d2RsaGRL?=
 =?utf-8?B?cmZDY2FPY0dwTnV0SGc3TjRTdEY4dndBU0QzQ0dIUThPTE9paklaaVZMejhE?=
 =?utf-8?B?ZjdBNUJkZXQwMjZTT1J5dFpmR1FOWTBLbDFSdnloTFBVWURxUGNtTEtSNkVU?=
 =?utf-8?B?blAwQzdubnprWDZVeWtvc2QvRjNPbE1KMEhuRktDNnZna2kyQWQrQkFJNmJi?=
 =?utf-8?B?TUNGckhOT3VBOWlPNWNQTTA1UEMydEs1NmdzZ2NkcjZKSmZWcHVkaGQ1d214?=
 =?utf-8?B?dXVVUXJrTkd3ckRkNEU4Q284ZXVVL0liUkdZdEVTUXVwMEN1NGNzVC9GR0hO?=
 =?utf-8?B?NHNEL0Zua2J5Tk01a2FJQ2R1clBNYWRWL2ZzMFkrRnArRkFPdmhkUTBkWTBW?=
 =?utf-8?B?eGhSTE5VMEsxQllSMldRdkkwUGtsS3Nwc0UxT3ZGM0NPL0ZmUXFQRGwvczJo?=
 =?utf-8?B?VGhJY0VZdDlXSWRBOUlSOWV0d1lUajJiTDhERVFSSXByakF5b01ISXhFQThs?=
 =?utf-8?B?clEzNlkxWGgyeEFoQXBjeG1MVFRIZE1HeUV0ekUwQjBMU3Uwa0hmcUtIZGd1?=
 =?utf-8?B?UjJYSlJtWi9iSVRjZW9TMEFBVGt5QUZNRGJiMUQ5K2U0OU1lQ0NxakJsSTBU?=
 =?utf-8?B?bG5pYjhMVGdhV0R4UlNPNHgvSjhDZy9OWHhHeUYvWElEd2VGeHVQUWFKTjAv?=
 =?utf-8?B?aEkzemdLbHo5ZWt3OFJBVVU3NzBjRTE5U0xnU2h2RHJaWmgxdy9sK2M3Y2sz?=
 =?utf-8?B?OUI0MDgyZHRSeitwNVc1Nk1Rb1BKTVFhVU5Cd1Z0K3BCUmNITlJMUERCSDVV?=
 =?utf-8?B?eEhkaE52V0ljY3RvT2I5VTBydTVQVWZXdG9Kd2ZEeXlodnZjZ1FINmpZMUtn?=
 =?utf-8?B?MG1sK0FkMkdlQ3ZuVFJieXFHbVkyUCtGUE5GUTBlZjlweFdBTnRFSm1Fc2xz?=
 =?utf-8?B?c2hKQWRFbUxWay9oYmg5MjJtcDYrL01FbjJ3RC9SNDJpQVJRb1lZYjhiYkFu?=
 =?utf-8?B?L1JwRlhDSkRaU3FNSVg2VDFNNlh5bmlTMnpLZmkwb3dUWENYZG5iNHBoQXow?=
 =?utf-8?B?Yk0xVEhjQ3kvK0Z0VXFONXJLVDM5US82bmdQSG9WWW41TzVhU1pNek0wQnZ5?=
 =?utf-8?B?cUFoclhmTFExSjg0NEJuME1Ta1czMVN0WEVhekpUanpLQzN2a3N4YmIzbm9I?=
 =?utf-8?B?dlpydWRFVEFCSnhMYlhoSTlyR2FIODgxZmpkWHJOQ09lM1JPTE1QeXJTdGJ3?=
 =?utf-8?B?UzkrNjNFdlpCajYrWXgxUWtGNDNHTm56Y2Z2RGl5dmNOM0dpRFVZMFVZa0Vj?=
 =?utf-8?B?eXlvT2oxeGk1UGYyaUhUdGRDeHlId0dYOEg5ODFpWE9KOEQyRDVvSmpJOTdO?=
 =?utf-8?B?djhCeXNPTnZUMjh0L1JocHRwc1BwTmgzdjlMa3F2d0MxMVRmME1WRS9TMGNQ?=
 =?utf-8?B?NzFCQjl4bXhMQVpKUXcyTVk3dEY0aGpRbCt4UUJEYkhwMEc5dXNyYXhJYXln?=
 =?utf-8?B?WEdhWDJxZHNuNWxsS0pNcnJ3TWFzbnM4Ky8rK05IU3AyS3VIMkJXalYycGJr?=
 =?utf-8?B?clVRTmpSNU9Jam9oWEZkUnVDSGZsc2I1NmRERnRzQ3FTcVkyKzRXTndJR2lW?=
 =?utf-8?Q?ixz77Lcy3DQO1l146zGG8TwPf72zrc0Nxre2pvN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7242b80-80c2-4e45-0f23-08d95cacffd9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 09:47:14.9068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X/+6jZZnWl8309brFSHSgkSTSrJjnKSIb1niJEUzHEUkV4wAql91ZWa4yG6ZJaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 8/11/2021 2:03 PM, Kevin Wang wrote:
> the following message is allowed in sriov mode:
> 1. GetEnabledSmuFeaturesLow
> 2. GetEnabledSmuFeaturesHigh
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 97cc6fb9b22b..fd04391364ac 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -90,8 +90,8 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
>   	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion,		1),
>   	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		0),
>   	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		0),
> -	MSG_MAP(GetEnabledSmuFeaturesLow,	     PPSMC_MSG_GetEnabledSmuFeaturesLow,	0),
> -	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	0),
> +	MSG_MAP(GetEnabledSmuFeaturesLow,	     PPSMC_MSG_GetEnabledSmuFeaturesLow,	1),
> +	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
>   	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddrHigh,		1),
>   	MSG_MAP(SetDriverDramAddrLow,		     PPSMC_MSG_SetDriverDramAddrLow,		1),
>   	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddrHigh,		0),
> 
