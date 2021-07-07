Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A065BC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439FC61CB9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439FC61CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F2E6E855;
	Wed,  7 Jul 2021 09:07:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366E36E855
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 09:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsAulGDHYeG0ycKPpIYXmG05HVuWOJ4Ic39HtLSuW5UNfArcuwsdrN76tQ1+I6GzBaZGyMVMUxKqKEn3gD4apNLlatpqyimDhq4N7HFAb9AMb4HLoQG7rhSsFk5/6vyWOgp9M6sKVJ9Wko6j42XLIXit0bKkF2pzUmlbE9+WtSiVWWDqlwdlg8cwm3RNRnGmkewGMMGVH/cbXC/S+MKi/BnO6j/xxEjNCH3IYG3z0vRJXpu77bkQH9LJsrG6LZ4YqKjMvrNcqDNJ7jon4lo3I2HwP8kEEGv/OW7akm6JoEzU36CYuBKOUXBz3qLs7h2P7w3zYno/kRrntrVJkJIQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDR0gJAZX+U71Rpkr19Oq9VipnXFe9DzdPDb5q65bSg=;
 b=YE51XDDE0yP47YCIGygvEiu8S0DC/VgPWeIFoXRDYq0sSVuAwBrSDOFpLA08Yp7YXRJVk55riULxSpZ7fu932vc/ftvm8F+pv77XT9R35ZFTbYQomuE5/ac+pSf/KoHkQgtpzu16OouJ9KPKAoH7pc8NUal1GBCaE0pymNjezQkjwU1i+nLQkZtLAxn9ECD1QI7a6+f5LG+tVnQAEX9QjzuCDGXgp61WSy8kxw8eOTao0tVdP5ojs0HkB5O7wcgPU4XutVzZax/TEgd0j3+MHov2EFfgZEguVRtzeVdHTbjEn2pBVmUWLfyrT7Jm0mcgdpgG8wGi2C5CKYlFlnwNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDR0gJAZX+U71Rpkr19Oq9VipnXFe9DzdPDb5q65bSg=;
 b=eODHwBAf2gfU8zO5zXVs8+Jryu9W+yGt7PL5yJV4iU76jOun5gvmajI00rh42plu1sxLzm+OVrpZGikFU6mQE93yhC9qrwJcaPlv+JVAyxmmW0T6B+xNYak3lf6U8Lmt3hTSt89+uqPs9LAWQVOJzJdPyMQvhmdgFZ4RbxQl1fY=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 09:07:11 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::3495:174c:48e3:4012]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::3495:174c:48e3:4012%3]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 09:07:11 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: update header file name
Thread-Topic: [PATCH] drm/amd/display: update header file name
Thread-Index: AQHXcw8sI0N7iGu8LUqAS6tjE4+UEKs3OHfA
Date: Wed, 7 Jul 2021 09:07:11 +0000
Message-ID: <BL1PR12MB523760F3AB1AB7CF2E8D2132F01A9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20210707090440.30958-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210707090440.30958-1-Xiaomeng.Hou@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-07T09:07:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a91e2f5a-b1e4-465c-ae7e-d7f6df255d77;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b048da9-2268-4f80-a934-08d941269b25
x-ms-traffictypediagnostic: BL1PR12MB5175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB517501E213345AAD47CF818BF01A9@BL1PR12MB5175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: poccbNlpRjC7ABTTVC2r0jgu+fYW8Fn/3x+ucmTSnIliiBBeqI7BC75tf5TceGQCU0Avdx1fVsh8Tp/3iW+sOS8sJHUkI/UQV2pewIp5LHUZ8aqKS6Or7ENbaJdrdVzwq9/puTUX7XMqdkCUU8z9Ck8jvFFoPHhtd37/Mt2/ojuEymO7QxrPILb5uHLvQJiCYLlhpvNyqkqQCfHyHkXtM8LKNkSMcwV/GzE+32cv6LoFEUjXfXEdIw7gCzv8fnUW0clcOWiMZrDjj/+OmYXMyywhfDp4u3hWm77wMd1hDUH0sr9HLwMEOchRqX4tDU4NLvOp0bfi2HmwMX2F0IgeDHdeTe0c5MQAOS6BvURxSW5HyfuuJXA6hWN+4m58+ZZOhTiyQz6jPfJLvBNQq4mKEVD2PFaR/SjS6hQy4ZU5q3L5O3uWVDkQPWago9TmEG6VB0v4OMVMbW9n4HxCTMt3iLimuj72OBoL2ObKqjoMTZEkrg3RE1bo713t+2lFFiMWFruhgR2QB3VwcXAtq5GEp5Vygtb81Rbx+Fu5hX5xaNk4imgvtJX5NlUTBS2aJNG4mJu5JfMApKA3SjIhB55HCJGGyPWAyNBsC179vC2n3BoIzqhsMZqrNsNy89fkbO36HWksgZKw9Y2zj11weEtGfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(110136005)(83380400001)(15650500001)(38100700002)(26005)(66556008)(86362001)(66946007)(2906002)(7696005)(478600001)(53546011)(186003)(55016002)(66446008)(8676002)(5660300002)(52536014)(76116006)(33656002)(4326008)(71200400001)(8936002)(122000001)(66476007)(6506007)(9686003)(64756008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GY/OgNhyGLb8kCJKdFSmUEWoIxVlvH2YDkC0Od1Dfq6nMYOGD1cRR2bdSXuP?=
 =?us-ascii?Q?LQcsETUZSyZb1gRIVqZX6RjBzDxp7P+Llw1GXRoNwVzBMncz90wTDsrDNtxG?=
 =?us-ascii?Q?gw5Wo0LcGyq02nQg9D8TqbPGPEYaFgcDwWm204T1Wt3dRpRbeu0N+0/pNyyB?=
 =?us-ascii?Q?V/cgrP0zJ4mGsQeqRWWtOjZ9g53iuATIayHVDUtTgch775OeOQZvMpMqC67w?=
 =?us-ascii?Q?8vGNFNMi9rdPiMigJ7py0L0+bD4wkLPOf1rBYfz40WsL8RkdXMe5QWkUVyn0?=
 =?us-ascii?Q?QBdPw00hcGDQhkK1WgSXrzuFo0vFlp2CB6613JPeWoEJ1Io5MtZzql1UV3JS?=
 =?us-ascii?Q?8XXIokRFd+SUBWPK1YABfP9J/qcsA+xsNzKq7XrYG3rgmx46r6lHTPFJpyXX?=
 =?us-ascii?Q?WCqM9DuuJGoQYxtf8AztsUKaAwRWb2IRw4SnwOdFsHwOR9b8cRXEkh0tAk5I?=
 =?us-ascii?Q?+EIOPXe6FodB8eGAYjNJFVl4m6mq1t4RjWY4EGoFZZ5dfH66nsTyCUbsqHGf?=
 =?us-ascii?Q?I3JIzoYRgyWJtz2OilDU85Ei9FB4F/Aek7cSPjiuVd6Paett4xsqc/Y2PzkN?=
 =?us-ascii?Q?M754UFPStZMty+ZQHd4PxCudtCLpog/jaJHXBzw1UTFGKNfYUFMEoWcKj4/h?=
 =?us-ascii?Q?fECej5KIrmZQUKQSfB8TwNTm/B7sUJbMAR730KcF9gGVuLA+soBOLQv0N8t7?=
 =?us-ascii?Q?n/bqg22exB3KWweCnpJR3N+FfqgkCLAQLK9dP0RcaS2z3gCtRhZZHF7d8zwT?=
 =?us-ascii?Q?2de4VB+w5TYUfYhfK57b3j0UUGWQklpWsyvCHtf+e2LLbHDeh0zmrkmGmW39?=
 =?us-ascii?Q?KV7Dg3YXk5oIDuvRpCcEHnDUHc/u7X1k/mn5bynvHY+EsOxXJ2w8nCgb7+8W?=
 =?us-ascii?Q?X7UKtUs53JxFy1NfokzXBd6awYHPYeQhY89sJdQk11ZUdBiliFzes1YohoPs?=
 =?us-ascii?Q?gXJaguvpkpr/tKwOOhjZ7x8wOr8QEJTZAMFhgcoIjlB9Lk6xofOtP1ovYAY6?=
 =?us-ascii?Q?aWvcBGPyBPrWbj63pF2AVH1I1+0ENQQ+lMQ1uelikLr+rWI/j7KC9atq2yxP?=
 =?us-ascii?Q?qQpHxZauCPSZY4Y39+xxbgXWg7NOjESo8bOciSNQ7hwXBvfcxv/IwlcQoGhc?=
 =?us-ascii?Q?xi99Uj90mxLieQrx4Hh8c7LRLyGOJWrmxs6TjUcfO2vlvBPG0TxUZqdCCRJf?=
 =?us-ascii?Q?CVQiKl3Q8C+v48waz7xiterFPvcAurfXAbOSq0Owpkzt2Xm/fEWK7NC6mEil?=
 =?us-ascii?Q?ueNWdrxDwhvtPpfzDq+v3ed2ptM3bb+10U8SpZfcuxpvAwTufD3CqbnbKmka?=
 =?us-ascii?Q?89dFrwAdUDTw3hTv/uRY5VOy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b048da9-2268-4f80-a934-08d941269b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 09:07:11.5532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KcM00wo8iVAC0mRoO+Jh2He71MiDNrfe21IOHRcoI5TQNzpwo3JQVoTWyy6WWsa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
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
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
> Sent: Wednesday, July 7, 2021 5:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Kazlauskas, Nicholas
> <Nicholas.Kazlauskas@amd.com>; Hou, Xiaomeng (Matthew)
> <Xiaomeng.Hou@amd.com>
> Subject: [PATCH] drm/amd/display: update header file name
> 
> Update the register header file name.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> index beea961749e1..8c2b77eb9459 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> @@ -31,8 +31,8 @@
>  #include "dcn31_smu.h"
> 
>  #include "yellow_carp_offset.h"
> -#include "mp/mp_13_0_1_offset.h"
> -#include "mp/mp_13_0_1_sh_mask.h"
> +#include "mp/mp_13_0_2_offset.h"
> +#include "mp/mp_13_0_2_sh_mask.h"
> 
>  #define REG(reg_name) \
>  	(MP0_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] +
> reg ## reg_name)
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
