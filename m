Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60908C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 18:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1503F20735
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 18:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2YiluYcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1503F20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8ECA6E0E1;
	Mon, 13 Apr 2020 18:08:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6447A6E0E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 18:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyOvmoHghsXY0NgzrbRiBs1lrgtW1ztVCBTF9Q+iPbjkhP7VPY7Za/8OVfGed14KgBNqVGxj1l2dBXoV/QrI54jMskyGEd58PphHFOI7/nC+1LRI9U7Rbocnvw1Du3OZ5mqOKf0ycy1TjKyatuRFv8yAq5x0J4rJRgCVh9iWvLV6FlSW0zA++bI7GeZENKfz9YUz8+IK7x9Em7H1KKj9VFXWvP3JkBqghW2c02zF/JGrbtgaJQKmKO21FV8kp/+KB/Xpt8R1UjxjrlB+9JL8zUuMxG0JUk7xqFg4rtm9VVYyllzt5iyWIFIsEsbbWLBrtxvvLw9iBNpFNiQtj/ygCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0ZbGxXT3Yj1Kmc9tN/jUcXeAQcA2VtqpDoKWO8dUx8=;
 b=VKRMVAanXZm74+ivigPy8l9L/8SlRmo84Bdwad6fJI1lCaaE/HGujxoy7ahKoepD1jAd3pQSZkmBBvo77kMwCBvo1b7x043HpLeHmtj/3fX8ubzaIJvo+PxhLzmzfapZOzD0T2OrKscJkS+zBaTOuaHtelWHwMzOMLq+JFIbtEPGz2ZPRSCalKwZ/BDblZHOiFv1DqMCzv0UciyA4YMUl6EysmQXrSAEIYKdgqB1e05KvBbDi/RqP2P39pGoA+6pTHQoC+sKkzAzqTNMtmDKrx8SlG8ErTBpBPkdoJVrba2RtUp0OnH9yjFnGTpA9xKE77+U0HioZzzqcemkY8huHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0ZbGxXT3Yj1Kmc9tN/jUcXeAQcA2VtqpDoKWO8dUx8=;
 b=2YiluYcqXnHMjfIDxcGVhHRyyqRVUYcXg5KyQWmkk+EDLkjDZ27BNtbbCC4TfMFNlTStN48ZcOObg5F35eepRN2rE3adMNBDSW3uxll8dpUL3lSUWWv8BHHAeJjfGsZ+qzTRPO+aQVmTGWFI3qAPnbRaaiDOCxnjJJA7FSZso0w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2536.namprd12.prod.outlook.com (2603:10b6:4:b3::36) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Mon, 13 Apr 2020 18:08:55 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 18:08:55 +0000
Subject: Re: [PATCH] amdgpu/vcn: add dummy feedback message
To: "Liu, Leo" <Leo.Liu@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1586797955-24224-1-git-send-email-James.Zhu@amd.com>
 <DM6PR12MB3914FA92EBF1EBE5812B8E6CE5DD0@DM6PR12MB3914.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <ee0745ac-0198-eef9-02dd-959de92e6bc2@amd.com>
Date: Mon, 13 Apr 2020 14:08:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <DM6PR12MB3914FA92EBF1EBE5812B8E6CE5DD0@DM6PR12MB3914.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Mon, 13 Apr 2020 18:08:55 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f255e85-7b73-4334-f288-08d7dfd5bb19
X-MS-TrafficTypeDiagnostic: DM5PR12MB2536:|DM5PR12MB2536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2536723653964B72BBCF3037E4DD0@DM5PR12MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(956004)(2616005)(5660300002)(8936002)(8676002)(6486002)(15650500001)(4326008)(186003)(16526019)(45080400002)(31686004)(81156014)(16576012)(316002)(966005)(66946007)(26005)(66476007)(66556008)(110136005)(478600001)(52116002)(36916002)(53546011)(2906002)(31696002)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWyLQ9bdveRl+teGvSWafSSZVHOwzlbU88b17Sub20uGkhv0e/ez5SBUf1noAErYiWxsqVaaexNtblwG3tiBZtNxH8+sAiVhHpYVk6H/Dojbxtlw0CRUxI6IICYc+qXlFqWnn7aFugAr4hvBdfXR9q0bAH8WcR7WtIKft3MkGct3QP1C+rdC8W62/CTrKsIRrrAS1/QqvkmXzp6y6Ye1JOoLoVBXYMhGPdr//2QSJhOGNz7B44sH3mAK74u1sdLdrrR5MkncE1GQTxGSS47zs8JHqgRptsjmzEWLzkBXABne/bsGRYsfQY6ysPiSv1oCK9+GY+/Ucz72GZVnZlM8xdVv//ReYVbVgTyLXg8L6YAnsA2F7aTD0QIUwht9Hx7+ZrbujAwBpxPw+aUdLULIAb1DPifNfa2cPdeigg3WOipY7lQ7erqMs7Cnghfwc3P/uRZJtGOWnMB5Ax9k/bK34lTRus5AjIlQYGSttmC+FqM=
X-MS-Exchange-AntiSpam-MessageData: 1rckmIorPpxtjjrM2TZPc5lwYWkmNzemAXlAV+SYRWZveMHMiyj9kHMUmwBmmhdLNk7OoX734reNVrxfdwAaQH/GvMYw8lCusMpEJHLbuynV7izbgM7RQkYSl468gp/R4Ew0kDbTtrhes1PhCV7jOw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f255e85-7b73-4334-f288-08d7dfd5bb19
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 18:08:55.8111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beSf27WyEB9VTWrNRx+ISXQ5ngEij+fV6ZbxOk2qhXGQuVAmXnxD/smaewaVQdnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
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
Cc: "Li, Pauline" <Pauline.Li@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sure

On 2020-04-13 1:34 p.m., Liu, Leo wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> I think you need to create a MR for libdrm patch, and the tittle should be like "tests/amdgpu/vcn"
>
> Regards,
> Leo
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
> Sent: Monday, April 13, 2020 1:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Pauline <Pauline.Li@amd.com>; Zhu, James <James.Zhu@amd.com>
> Subject: [PATCH] amdgpu/vcn: add dummy feedback message
>
> Latest VCN firmware has feedback header check.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   tests/amdgpu/decode_messages.h | 4 ++++
>   tests/amdgpu/vcn_tests.c       | 1 +
>   2 files changed, 5 insertions(+)
>
> diff --git a/tests/amdgpu/decode_messages.h b/tests/amdgpu/decode_messages.h index bd6fe4b..0dd80a2 100644
> --- a/tests/amdgpu/decode_messages.h
> +++ b/tests/amdgpu/decode_messages.h
> @@ -845,4 +845,8 @@ static const uint8_t vcn_dec_destroy_msg[] = {
>   	0x03,0x00,0x44,0x40,0x00,0x00,0x00,0x00,
>   };
>   
> +static const uint8_t feedback_msg[] = {
> +	0x2c,0x00,0x00,0x00,0x2c,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> +};
> +
>   #endif /* _DECODE_MESSAGES_H_ */
> diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c index ad438f3..0d8df81 100644
> --- a/tests/amdgpu/vcn_tests.c
> +++ b/tests/amdgpu/vcn_tests.c
> @@ -333,6 +333,7 @@ static void amdgpu_cs_vcn_dec_decode(void)
>   			avc_decode_msg, sizeof(avc_decode_msg));
>   
>   	dec += 4*1024;
> +	memcpy(dec, feedback_msg, sizeof(feedback_msg));
>   	dec += 4*1024;
>   	memcpy(dec, uvd_it_scaling_table, sizeof(uvd_it_scaling_table));
>   
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Ce06ed3031a8e4c5de9d008d7dfcde4e5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637223947784156110&amp;sdata=lkYADqz5Pqcu%2FYN%2BBZKzJHeCV8NypHniPBBHN3WD40U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
