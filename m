Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E74C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 00:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332E920672
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 00:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xml801+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332E920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EBE6E892;
	Thu, 25 Jun 2020 00:06:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518356E892
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 00:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSWwFnZWnSH0dX21Y5JAE9E4UbYm9bA8XGk4QXhDZhrIpP5ovGezhgZ9F2NMaxDlbUqOBp6yTpMm1ifqUhxU4FW5slsWUrXFQNwKYkyaQBt+T7GByNGcANLDp2G56H1s9XYjo7wtUlHe7D3Mj1b4C6mWtdHkBssCLv1EtBo5Xf/OAxP5hCJUqlV6X6Le5k4+YuaGaDk8x233r9RF+o0MHPs/aU5/lTRdWtNsnD/wKKtbQmVGBGQfOcqEFQmq3c4NMgU+3rFYNh9bqD/f9JyxVAMT3QFPX0voBZCE2t8cTwumAnuoSrnaUmoOuxNiUddvW479Wb3/SLWeHMezyDyhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn4dJnAlzO+HMNBELx3+ma7tlum5qNV6TQ71cyxYTxs=;
 b=UYAkQaPxLfZD0vQ+adQ6T2WUWyMuTkjQrTShwYp6GoaJI2Nj555a8b+fQKg9h/UaWrC7wA8F2CHOAKUy0HjixCMRD0x9933s45mfoIaDDXdlM2nAEIMA58KE5bbMLp3Km+PqbAJRWbXorQKu6PRq4aPmzoNfQ6/AQFFWt67NCUloZQ168GIBqqkBJ4I5+fWv2rxNi+zFealIIQkjpk6If6ktDeNOKIHPGxKRE/VlJax3EQ4AYYULAnLSK/zoUR2hEeOydoqTs1utZPHVMvL2fwlG3i7B9X2GSxzBbt9dyY7f56d1AmppfVHkprBf+/B8r5iw1SCW7gjDOhzWPVxMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn4dJnAlzO+HMNBELx3+ma7tlum5qNV6TQ71cyxYTxs=;
 b=xml801+xzQ32tV1/cJg7cuf7k9BSDiZPnVScgNR6gRblCqu+yt4lj0N8R2hNzgUR6eGg66dlwHsx9PejrdyvUltJGHPzb5dBLbjttQLsGzbua6MWRDvoo7EpjsWTNCk86il6fw0jmZ4Y2TS8lN6MLwGw4VcoFlsm7FwRdubrwDs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 by BN8PR12MB3028.namprd12.prod.outlook.com (2603:10b6:408:43::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 25 Jun
 2020 00:06:24 +0000
Received: from BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2]) by BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2%12]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 00:06:24 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable runtime pm on vega10 when noretry=0
To: amd-gfx@lists.freedesktop.org
References: <20200624190519.2378793-1-alexander.deucher@amd.com>
 <20200624190519.2378793-2-alexander.deucher@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <59f8ba89-24d4-cc1c-c573-41534978d262@amd.com>
Date: Wed, 24 Jun 2020 20:06:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624190519.2378793-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To BN6PR12MB1155.namprd12.prod.outlook.com
 (2603:10b6:404:1b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.34.178] (165.204.54.211) by
 YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 00:06:23 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bc5e8a4-bd96-49e8-0037-08d8189b98c5
X-MS-TrafficTypeDiagnostic: BN8PR12MB3028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB30288BF6F2F84D44DD6BA8F7FE920@BN8PR12MB3028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xr3ioaDAHbKHqS+Vt9bO5/do1HHxR30tg5W3KYjQfyAnBA9NXkZtVaEvFU2IoEASqgjf8C1biE7FrGonIpnwMtURKDbVCGctkDTReLF1B7osAeTU31hm48wjeYW45s4a/4qRIu+Kl+fMw6ayd76H/dPEp8snga3YscNhU+RCH5EZThDJPE5n7ecio1xKcEJogaKDQ7BpzSh2aCGwEfWZsjf/1PGzNCcjtWaf5g/XLpq1SyEJAE/PYgePhZZacm14BzjgqrCD66HHXE1PutnlJkhLHfJaqHE4hw9DTybQROcxzVO1ljCb9q2w35xxt9UkO4brGS6QgfB9KdkcDINKrzAJ1GvFeCoEIO81cKFFjGVNxtm8MDHZ9ZdbW0ecKGqCSSF75DQVOz9T/uvJxsHkljI19+o6OXZjkBoJwnHzRQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(316002)(31686004)(16576012)(478600001)(16526019)(26005)(186003)(52116002)(53546011)(2616005)(8936002)(5660300002)(66476007)(66946007)(66556008)(6916009)(2906002)(966005)(8676002)(45080400002)(4326008)(36756003)(956004)(6486002)(86362001)(31696002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: V0Zi6pv3K5Sev9HdFp3AVuWiSbpJda6pvFzKQ77yY2r+tLUK1xrKBv1vQDm7c3OTUreoOhqvXFGoSOsXsbiToBw/Y4iSfwNaUuX0XH9bS+Ra7Iu62JoAEady82+ZUQx8VSDhsL5Lk5383vESHBHRLA2/VlrPAsCQ1MZnwyzPoKXCDzrJoXyCRbMgAm4OXa9jpppnlW5Ulymvl4KKt8+R20t4dkf3JxC8Emy2q49Ay0t3CFdUYtnLB20PSOCU/+xHO2MnaiPE5RO8TkBiTAC7acTM8I1E7QcSebXLw7ixnviVR4FWN+nSSAGgyh51/iZXC/cF/VUDhuWVh5I4QmLJfhp+XTeXKJ5VZ5mhgb9PGPm6uJC8jGVW6t0ypUAmFSM/nZZxN3t8pTL8DuVBAOPggOye2E9aMAiQHRAtJa+LBo6eeUYtVVYgxNB2KVO0PJniqaddCq9FubuwJAWa2rmVYVNuRY7hcxXu6c6El/mDVfVNqC8QA3MWXcU0m1gbtz5D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc5e8a4-bd96-49e8-0037-08d8189b98c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 00:06:24.0117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkRMRuDkAcE5kmIgZH5CMbDY/YepQpYss0i8Zooc53Ocl1hU8s0kkkFidUj/qQlTpdXVoiqkY634fnR3mAuuBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3028
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
Cc: Felix Kuehling <felix.kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 6/24/2020 3:05 PM, Alex Deucher wrote:
> [CAUTION: External Email]
>
> The failures with ROCm only happen with noretry=1, so
> enable runtime pm when noretry=0 (the current default).
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 0fec39eed164..341d072edd95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -176,7 +176,6 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>                  case CHIP_BONAIRE:
>                  case CHIP_HAWAII:
>   #endif
> -               case CHIP_VEGA10:
>                  case CHIP_VEGA20:
>                  case CHIP_ARCTURUS:
>                  case CHIP_SIENNA_CICHLID:
> @@ -184,6 +183,11 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>                          if (amdgpu_runtime_pm > 0)
>                                  adev->runpm = true;
>                          break;
> +               case CHIP_VEGA10:
> +                       /* turn runpm on if noretry=0 */
> +                       if (!amdgpu_noretry)
> +                               adev->runpm = true;
> +                       break;

Though it fixes the ROCm pytorch issue but aren't there any stability 
and performance optimization concerns as it will impact recoverable page 
faults?

I have no objection to this otherwise.

+ felix

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>


>                  default:
>                          /* enable runpm on VI+ */
>                          adev->runpm = true;
> --
> 2.25.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Crajneesh.bhardwaj%40amd.com%7Cc985ef0414bd41b48eb508d8187196ed%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637286223437553622&amp;sdata=wRJbu3%2F3zu%2BHZ3KA%2FZmyh1yhgATM2zONRr%2FvI5KsxrM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
