Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4734C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 17:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B0664DD9
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 17:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B0664DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA036E1EC;
	Tue,  2 Feb 2021 17:36:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A776E1EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 17:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0LkctnAFvbYffNGC/ou2OsR366IC3NNttg4Cs3wwnzCHqhjukm9pBpL/8YSTnBWvZXpDLJAa46rRBNB8SI3Pq2v1riNJi79r++6fCTxsvpAKi9V2xU6Oa36SALj4bMNwN+33QxIg2fHsYEuHZreCHeiukOINILhFKMmf5yFDF+ip8v77Wb9sYvj3phislTNiTWWJpdf7cgQCCyqgkyYtAEc9NxhWxK/wMpqwFgqImdC0i0hJ6NXcJS9gNkhROEOFujZQRyJPqkD7obNqgTVEaCVo32JKNOtue5SCmFFB5io3TxQW1gtmxBAZDQOtj3GzTs4utKBCSRpckO3dXsgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCS0kcwtWQfszyNXlW/UUqxLF28S7btH1F5nk8+FGM0=;
 b=gh2zIwfRuLY5xl+fLu9BZER37rEMjrjDApGaYu+XTRfqHRPEunhtQvO1oJ+ziY5OPluatBjLlJOT23A5rXacGw+EVif7PgI/hWcVeAVVdxlt97jdzjXYMuV18+4IZRo7Q2Lsss6/KqUy5BZeVC3GUwgwNM7//ctL10IlWmBlVmcScRgKSHDC/BRy0v2I4ndF948Y8Aey4R7+IlGeynJPki+EaSNr20bQZTt2ZgLnTB9GkRAThQoILx9EFU10XuupYSQk8nHCon5vNMa2pVY0FCypj8ll2VwkrUIRWMgNiuouQ46k/XDHBFaBf877/QZiIrcCTeJWGWcqwkrdRX6Yhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCS0kcwtWQfszyNXlW/UUqxLF28S7btH1F5nk8+FGM0=;
 b=AzG52SbD/V7bZ6WIP1/OggUXv9ntlZGpqcyraY9W7AxWjF1ArilBEGravuDILgug84pddb+8O19YZtik1CWlU5n8IKYcRnVBaEDsSH0NuCXa7a0v5C5k1njiVBnGN7clswDi4Bz9CK8YbZFq5HLOtUe0LiSEOu0Hobw0MxO8xkk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 17:36:41 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 17:36:41 +0000
Subject: Re: [PATCH] drm/amdgpu/smu12: fix power reporting on renoir
To: amd-gfx@lists.freedesktop.org
References: <20210202171641.1062381-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <b0f67f3a-8266-5ac3-8258-650e5500b284@amd.com>
Date: Tue, 2 Feb 2021 18:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210202171641.1062381-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.32.71]
X-ClientProxiedBy: AM0PR03CA0046.eurprd03.prod.outlook.com (2603:10a6:208::23)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.32.71) by
 AM0PR03CA0046.eurprd03.prod.outlook.com (2603:10a6:208::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 17:36:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4c79245-63fa-4058-4849-08d8c7a119e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3433:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3433BEBDCBD87F34444978528BB59@DM6PR12MB3433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPc7AlPdbrV74h59nRgsunU2bJGH49BnGKTUDM9FZQCblGtCtE3OnBGC9E5QTO0r2IWZ5hNpqE4Z9ACK3VHrrWhrxt73rXFwF5y1OLbkaMiGAtLu7JiPH6G7OgL5Yv/Am5lwd10hE3pjoag5jO26rp0frOWnKJj4PMGSSpbrZUg95Dc3Y1vnJh46J4ZtWeOpYMlp+X8f7uSGG8MSWZDpt3zaGGham09W1rJUupUGFsBH+UDxHzPwvCQGIoYvxcG5jxWKSpZoZugVOlavDEJiUqBGkYBfUiZ4OrqMJegqNjKA6U/6YntqA/jxhlaoICwOVH6Ek1d+UHOQSAQl2MgBDERUlYUS9aTAV0uxRG2tX/qubC4wSCVawWQByP9wRlz1lXpJVZ7zzTvLzmvyrsgxv6KgKht6rWHb3ocO1QlK7X/VnHTLIAQWlq1sSkrlhLWz+w4L1t9Z1BBE9iQ0N0IweckjU1LSKuf/PNLZinbpxq/l+7B8iNe3JyALxjk1fBOmTlZTrbkspVb6zSWBIMXgDNgt8fH7KREwVk76VVkcUjM/Ww/8Ha9hLtiuGI+5hNJL0Y/i3uyscPy4dC+kx+Kfw33hdnMkNcdMJPXLSvPEP29GALqr8vygZMNZ8xhTl2i2Z3LZ2bf9zXqrBHSVz+wyvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(6666004)(16576012)(52116002)(45080400002)(16526019)(316002)(26005)(186003)(966005)(478600001)(5660300002)(66946007)(8936002)(956004)(31686004)(53546011)(66556008)(31696002)(2906002)(66476007)(6486002)(36756003)(2616005)(6916009)(8676002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TmV2dkJCYlNQc1pkT3JEcnJHYU5SS01FampKZHNQYXkyZDZLbktYVGpvV0pY?=
 =?utf-8?B?MEV2TzZmc053TG1Ub1hBNDZwbGZ3WHhhUGR4VE5MZGdMOG9YUXFoeVJwTUw1?=
 =?utf-8?B?dk1pbkZVeG8yMFMyWldlUk5wWEFxd1ZBS05kcEtiVTRjZGc3TVE5cm84T04w?=
 =?utf-8?B?UmV0bWhLcWVBdjZKa0xLT3VkbjRtTnNOdE4vQmJybXk1WTJTblRrZnBsMzZX?=
 =?utf-8?B?WG16REJRbUtkMzRjWXBFRHBmMjIxa2xLbzljWE13c3dnd0Y5ZGJGMWxWdXEr?=
 =?utf-8?B?aWtRTTg0SHZrR3duNGMrSGFFbmlOZzdGSzc2NE84WUdYUVpiYm94RHFGQjkr?=
 =?utf-8?B?MGtiL1RFcEJtWlJkR0YzZmNDbCtJSjVkaXBUdWdkRVJhMUFVSzA0SGc3aS84?=
 =?utf-8?B?ZmFqTDlNRkpEVUorOE1NV0pHejh4ZVdjZUdFV0EwMWJ6T1d0OEwxK1gvMVhU?=
 =?utf-8?B?eExsdlU1Z2NNUHgyaHhYY0x0N0FsbXkrQXZLamw4MDJLL3BiTXR3NGJzMW5y?=
 =?utf-8?B?QVdybUNoS1lWR3I2RG4vSm13VWFuU2YxT2ppRWp1U0M4cm9YQTZJYlV0U09J?=
 =?utf-8?B?TzVwT21QVWIzdjIwM1U3SS9TUXFBWUp5UkJwcmpXb1JDM1Rhd0JBNG8zV0FZ?=
 =?utf-8?B?amdiYVV0S2RwQmloMld3TTZncVlGTUxYNWFqM2JhZTRadGJQZGx6WENBamd1?=
 =?utf-8?B?bzREaVVVaW9UNVJpV1hUdDIwaVJRd1phcnkxSlRXZUlKbU9jTEtvcFVIQmtE?=
 =?utf-8?B?a0d0dG9hN3ZSYlkza09rb3lsaVBYRzh3eGprcnZzZTFITjlqeTZYaytmcGZr?=
 =?utf-8?B?dUNJVHQveGFZS3F2V0VnSW1qajJxcEZVL1RSaFpBWHg5emhpK3lkYmJuY2cv?=
 =?utf-8?B?dG5WazFsZ2dkWk1ET0NiU0R0b2FWVmY5b3A3OFVnUlZOaHcxVFNiODBMcWNO?=
 =?utf-8?B?MExPdzM5RmVJQ09NL2dLN2hsMmZjMGlwc054YzBzeE1TYjdzcEVldjZQaDdl?=
 =?utf-8?B?bnlRSTRpR25qUVo3cFEza1A0dVhacm1uendpN0d3dEM0T09iRUViZit5UDRs?=
 =?utf-8?B?NzRaYjJMYnd6VVNMZGltbGwvck90YnBHaWJIZVgvdlMyTTNKRHo2dzkzcjVW?=
 =?utf-8?B?WUFXMjJNM0ZONkYySkJHZE1jWXZNQlIvT09CcnRTMWZ4bGFpSGhPNFhLdFF5?=
 =?utf-8?B?c1BYSmJuZDFESkhTdTN2Mmp2cmRFTW5PQlpZcVI5UTZYUVFCMWQxaW9KTkZp?=
 =?utf-8?B?VFI4UXhveXRJd0VjZEVjYXB0b0NXTWRXU2tza3k2NGJ0RUFqWWp5V0VzR0Zh?=
 =?utf-8?B?U3FKVTRHVFN2YkdMUE1RaGtoYWpNeW54RzNhSW1ESkNNaktxTnZDemJ0bU44?=
 =?utf-8?B?ZXNMcThHVkdKendaM1V0ZmFCcWt5dEJqWnpvQXp2VDEwbXR3elVFM3F6dkgw?=
 =?utf-8?Q?wulg/b+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c79245-63fa-4058-4849-08d8c7a119e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 17:36:41.4157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gELYW+NHaJIJAL6UZ8WF1Yhbb/G37zdbfeB0TDIkuvFjkjPVGurzS82yD3LkgJV1Sy3dZoeP9MXhgBJw2zCGug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 2/2/21 6:16 PM, Alex Deucher wrote:
> Align with Vangogh.
>
> Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1467&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C58ce04c3aa7c49734cd008d8c79e57d2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637478830247013939%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=hGmpeXS5bAb5iRaPPy7dz43bj20Z0btIeTXxFhlTx8o%3D&amp;reserved=0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index ab15570305f7..f6844b90ca67 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1129,7 +1129,7 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->AverageUvdActivity / 100;
>   		break;
>   	case METRICS_AVERAGE_SOCKETPOWER:
> -		*value = metrics->CurrentSocketPower << 8;
> +		*value = (metrics->CurrentSocketPower << 8) / 1000;
>   		break;
>   	case METRICS_TEMPERATURE_EDGE:
>   		*value = (metrics->GfxTemperature / 100) *
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
