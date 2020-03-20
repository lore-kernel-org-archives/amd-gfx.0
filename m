Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E6FC4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516E620709
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a+d+wB8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516E620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D900A6EB53;
	Fri, 20 Mar 2020 14:37:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664E26EB53
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 14:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWcMMcfnKUje/0CDbkMees9aZKaNOk69rT7bk6jFmTIVOtQTeU2ijFJOU6vlTNRlHwFg1NVFdDZiZVRHCI26gLBmsmk+9BmdgA56QFhpH3+5WzdyB19hQbPUDn6cX/lfvFrgCu2aqKYGizf7IzFHEclyotHycnVk4MAmI47wMxnZjp0TOIRKlhVUmZAinM171F8bxFcPZ7IAT+LIhposLJI32GCXTraDFk83pmBnSz0ERUQEcrwJGwN9qT9JsYPajN7aM9XrDDERonOg3rCBbW1i1jRHxcXOYyBZB91HB/ceImswZ8/3wBuO5XzZ43g/XdApLJJPPAEiLAy1IqEPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fAJuQJtVPkYDqYk2DwgqaaxozFUsRKt11ncBZ5fiRw=;
 b=CyJ4+KWkKVKDo+Pl+Ve6pV8zqn05IW0B43nCMmiWJ9LW+22YZonNEcXi2S+NIr/G4wLCk6WHJ5a5sw1Io2yMAbkvPr/QmZ2nMPMutaZA+Il6/zknBbk1SQkuIoGLRc0jdIVKksHcCrlqw/7FgeX+UtW7znKbIMxxrXp5VKZsGL39ZVNfz4XeGIDz/UISlkCSuLQs0O/VhbVdQwqhdHEVrPxxJTvqr06VmFFL8tstfnx+28uPvlPjLnuObs6gAQNQorEDyI2ru9bEXBiwUYeBEg40yGXJHqlzSX6PCy0gM4dANYEjwfJXmbw2L87pYN/i/OV6OghIc568ZYFm6ubeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fAJuQJtVPkYDqYk2DwgqaaxozFUsRKt11ncBZ5fiRw=;
 b=a+d+wB8CLPSqiMHUO7B4bGP0/EOTb1lH6df/ZPYtNic87+iGOPeC0t20442HbcQcJdQlnWisR2vpVVL2PR6+4Mc1gGhkZVNbdK1oJW1HFRi6Rw/ZReJ7z3roK7gBTeLreCJAksit2K/yjtH1jx8dKT3HSP4wdu0t0X8iFWigASw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0124.namprd12.prod.outlook.com (2603:10b6:4:58::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 14:37:28 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d%5]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 14:37:28 +0000
Subject: Re: [PATCH 1/6] drm/amdgpu: ih doorbell size of range changed for
 nbio v7.4
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200320002421.14984-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5e11d408-bb69-9b84-20d3-50c72d8967c7@amd.com>
Date: Fri, 20 Mar 2020 10:37:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200320002421.14984-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.21] (142.116.63.128) by
 YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Fri, 20 Mar 2020 14:37:27 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18977574-7cca-4c4b-19eb-08d7ccdc369d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0124:|DM5PR1201MB0124:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB012488500CB5FC6FB58FC67392F50@DM5PR1201MB0124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(5660300002)(16526019)(186003)(2616005)(26005)(86362001)(478600001)(8936002)(81166006)(81156014)(8676002)(31696002)(31686004)(36756003)(52116002)(66556008)(16576012)(66946007)(66476007)(956004)(44832011)(316002)(2906002)(6486002)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0124;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXzB8FZ/+IuoZacJAcc9zhX57RYOfc4BTRMF2fpUdTmoFeeNA/Ea3z8X2o8FhuVQ8ZxCy/XA96z80pNXZ3zoR3H3D7GQMNn9Xu9jyY57W4ostmFLN1E1tqyouLYZBkA5uZ6nrHKqjueLcszateyQ0EVKUQtRr1Eh2CV8WsAApFrVRRqUN1KVL5rijVVF1nU2D+6vBU8UMIOTfCTqCecJybisiAfcSaqre/fQjKr5vGMoTzKLw8QoQdlBzFncUmEkfN6Jd4R5f/Lx3oCyD/EkXL1xF1dbHBRfgvu7dMeaUigTcsyWoEBmVlZhQ9vKDOaeAMWde6nsIg0TatFxjUapXZn5cooBhksIvFV/RR4OTZSLtloek1RueatbT1zTZtQfVeuxM0rLLi5kB4/bidUeVDJJm/JzIhBQP5J18kPVxSAyVU9w87NYEVqAzOMOHeCw
X-MS-Exchange-AntiSpam-MessageData: F9YRzSlpNWmjN3BMF3D0ERS7DtDqPmoxwV0q7cB+q1jQnreQg4MFEdjCinBEkaMjR6kLlcuv9CgzEUCCh/SMeADraTeL/JltJXT96e1lvjQEnSMAlQKHEeVCK1MRUqomgJ2oqHwuoO8sQbuSijclUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18977574-7cca-4c4b-19eb-08d7ccdc369d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 14:37:27.9910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l55AYcQANSPqvDMAC47RBjuFXb8V+eHr9Y0USYqJRAW/HgROgvgCMOFyWLmUXiODOZ0Ys4xpN0MPkhM3TddnwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0124
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

On 2020-03-19 20:24, Alex Sierra wrote:
> [Why]
> nbio v7.4 size of ih doorbell range is 64 bit. This requires 2 DWords per register.
>
> [How]
> Change ih doorbell size from 2 to 4. This means two Dwords per ring.
> Current configuration uses two ih rings.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Why is the subject "PATCH 1/6"? It makes me wonder, what are the other 5 
patches. Anyway, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 149d386590df..263dbb1f92ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -185,7 +185,7 @@ static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
>   
>   	if (use_doorbell) {
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
> -		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 2);
> +		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 4);
>   	} else
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 0);
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
