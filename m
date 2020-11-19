Return-Path: <SRS0=HxJR=EZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A19C56201
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2020 18:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FC124654
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2020 18:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O/h6EMi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FC124654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63B36E5C6;
	Thu, 19 Nov 2020 18:27:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C0A76E5C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2020 18:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNPvksoDPTvEbiGVEv6wR0gYmvI9kH8+E8vBCktbNIpai7eMbbcYilSDIZiRU45PWmXwxgK9V1qspej9Ig4+HLDEU0+pkZ2Xz/QR/F4+2xhuMrQSMrcic1ZJHkXi0ekN0I1sO3VE2xrV3iLNz7uuK/0IkonB6T6jNUCObj6ETEETGLna92DLccJVWlcrIm/9oAVq8C/LK5hQvi8w8MT4dUj6+glNfzSdXkFEc+Z1NZI5TUNuf6QDv5jxODGpkZNXkSSTG7wsHpTju3fP4zJyCASJkm1nILB1BAuhZnXTViO+E5z4zVMeog6PPCBw+VtviELt9hs147edi+O3swtMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqeqT5yUj7wWh1pRX27FQTOoZ8sqACWrsuBjWvhgs74=;
 b=HudDwT1qMHN92D2rTy0QXHuDRFjqc0QfAUu3MUPTWGM3IqLa9vvhlkcbU8AneQp3wo1J+QHGxe0Kg8DaWbGFqmHQQcIlH8dmtNmUFxYG05wa2NW76k0l8IcyOQmw/yLn7aCUOXibWBUz3dtMt1v/y9k/dze+Ga5o+MF0jidrHfwzXINppl/nX6USt/m83eyHLHtF8+MzzI3gaEdotkmCG73bbXZrqCOpuh+QO7ktL24eCZHWhIi24fvZtakKJrP2++WTDyIhFdDSayyiP2JsGi3IQ8jtWbBJLraajh4qtZl5Y5nWa6sNkb2WTWfZun9gx+cSY3mobTJrB2zLKVyXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqeqT5yUj7wWh1pRX27FQTOoZ8sqACWrsuBjWvhgs74=;
 b=O/h6EMi5NNXgLgTbCUG5Uo4FEwb7ZntrTAGhW+/8byasMhcabg0WUv7F0E+LbiZxu+u390HeOPDHLljfuVha76qy+uODON/BwuYsXu7A9hOCSMCQTJ57ARx6MCyFXWYFgWSHO/eddXQcH4TFhtpjIMqwfNski+nf54w1LMBlh3Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1779.namprd12.prod.outlook.com (2603:10b6:404:108::21)
 by BN8PR12MB3427.namprd12.prod.outlook.com (2603:10b6:408:62::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 18:27:23 +0000
Received: from BN6PR12MB1779.namprd12.prod.outlook.com
 ([fe80::dc42:664e:e7ab:543d]) by BN6PR12MB1779.namprd12.prod.outlook.com
 ([fe80::dc42:664e:e7ab:543d%4]) with mapi id 15.20.3541.028; Thu, 19 Nov 2020
 18:27:23 +0000
Subject: Re: [PATCH] drm/amd/display: Add DPCS regs for dcn302 link encoder
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 nicholas.kazlauskas@amd.com, alexander.deucher@amd.com
References: <20201118191910.2672820-1-Bhawanpreet.Lakha@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Autocrypt: addr=aurabindo.pillai@amd.com; keydata=
 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
 Gul9w6KOPkCni6aOWdaa4kvIZpWBE+E=
Message-ID: <751ed7c7-810f-8f6f-6b7f-90faf1bafa8b@amd.com>
Date: Thu, 19 Nov 2020 13:27:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201118191910.2672820-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN3PR03CA0058.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::18) To BN6PR12MB1779.namprd12.prod.outlook.com
 (2603:10b6:404:108::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.1.15] (165.204.84.11) by
 BN3PR03CA0058.namprd03.prod.outlook.com (2a01:111:e400:7a4d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Thu, 19 Nov 2020 18:27:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29a17c2f-838a-4e3e-b525-08d88cb8c205
X-MS-TrafficTypeDiagnostic: BN8PR12MB3427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3427C666B9BE9C96E669A6AE8BE00@BN8PR12MB3427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67CViXl+EeNOaCns3q7b5w2LZsLLHdfF30MT2mI6DH6tnXrReYh52iFai+g0yYA2RAnbE/g/R32xrq/eJPrLc0wkpfTwp4RcH1BvHIldcg/XLbFsxO21It+cydWN63sjt/0Qlf7Z2Xnu6gauBHxGDdLTuvOIPXIx0otS3Gv2n99tLqFn14yOeWbggm2sFEKS0j3mPQ8d853sL24i9i5XOF0wch4UN4nYA4QxxDK0P04ycAQfYlr0J4szXbritRYM6jB8gRhYOv65hXWtLoSIPduzrH713UHvyfRS+QtIdHOY/XS61kajxK3ZqygO6z6Wr/GIHCqsadzvr7Q0W7pLE0StjXm2XLOAMp0i8idk6ynI0VD7BZGQ75qi6FjLIN/f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(66556008)(52116002)(2906002)(31696002)(66946007)(4744005)(6486002)(8936002)(316002)(4326008)(16526019)(66476007)(36756003)(31686004)(6636002)(8676002)(26005)(53546011)(4001150100001)(16576012)(186003)(478600001)(5660300002)(44832011)(2616005)(86362001)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: swpK/6qY998Te633zUPmuDDm/NNrTwReq7CFnjbbQ3cISCkkm2sSiZg5PVc5v2Wg0QT0xQhVpo/ZxnD8+ry2Tzl0oEYxcRh6t6ZrGOUAscrrPszlGJiqx5s7q7rZNjSu5Cz25HtugZJKBrTT0dlWTMZo424mZAIwOe0RRSMvCMjz9DShx4v6G1VukbChZ6jduyW2MKKayGtompmgSpEYg6/LpMQqVXPrGt3WmjmG55YwKZFSR5HVI4eid08CbhdM0nFAEG4tV82U6NYPLTiN34IZ88RHZnMktwV+2q8t3GhGSXhZ8PdIltQzAWBoaMl2v17TboGFakJCrU7Be/GLNxc+umvsHqEJYxzCsWuUhdV7TF4dRy31wW8SOKlmLWOoABPYjyhF+c6Yqh3QIcABvK9BeeYP5nPTYAK2LUnFPaQVuwIb3NsZQ9mNa96qHle5tIFXgDjx3Q5gDbXcvbevksS/QbTww0Yc4mvz9iS1Po/r4qJhH8DD73ih58w9HUos627l+nc79FcrFQ+06M7aCqFsY1XcEMdLaLVU/FG2jqtjcFzlzg0oi/sfrTBIkknQ98TgY4uN+Zs3EUJ4gNetFRfcEO7L/D0cX1Vren2SdfqxooVg/xRlLsuaE7D7+60roUF/ZYFtvKNeAxFCu7D+7Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a17c2f-838a-4e3e-b525-08d88cb8c205
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 18:27:23.1689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2tpgHvR+zZUzqXMOsdUvKG0hq852c6omVIZAQcX9JwO5CpxvKa5Rnlv0A5PpRYFXsYsi0C/JkAvPBHFMIQDjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3427
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 2020-11-18 2:19 p.m., Bhawanpreet Lakha wrote:
> dpcs reg are missing for dcn302 link encoder regs list, so add them.
> Just like dcn3
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index 765002e0ff93..08ef1428550b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -967,6 +967,7 @@ static const struct encoder_feature_support link_enc_feature = {
>  		[id] = {\
>  				LE_DCN3_REG_LIST(id), \
>  				UNIPHY_DCN2_REG_LIST(phyid), \
> +				DPCS_DCN2_REG_LIST(id), \
>  				SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
>  		}
>  
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
