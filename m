Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA8C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126532076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GwMXh3iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126532076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0976E488;
	Wed, 29 Jul 2020 08:44:10 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0348A6E488
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 08:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRP6xfpkqYL7FNVyTknT/virXA+S1R82klRJpmFJ52zzOYQ/QJTnL9gKJZa5plgrfdDqd9jXqYJJlPLWVfVR7tVxab46K3SDvMaW+7o99Gbi4/CwkOB+k2aQ2inUyN1U5pNhQWjLJ52eK5TE9iLzMJAFOav9TDv9EKQQYE9M7f6dC3xUrgmHQVayDCQc7WGGqk9vdKQHNzZDrNGOar0on5I9RuMXS18NBLCCyUXGTg1bsJ3zkL0C8fiEq0tO0qWlYoNsPFDnpkXszHI33fVIp0O0KbLBtbnSJ/WGi4rbmqZ+vL5kOThVNKf4i7B90Bu4E5efwbWvMHA6z6rSan+LIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QKTuQmlKbZkKWrrCNvkwfwVSciiwu4lpXXbhtlz6B4=;
 b=llP5B88c+fFIkJRhv5yWcgmMQePyGUubQNJKzMXexnInXCHNAOGf9GXEETI0GLo+bp+qgi4/T3aa7oJ37x/sUMADk3wN/mWcITMM2v9MRPn2olhST6Eqam1vK/ZoXSLS4b6O+UcW+2ZJTtSvncWIxkXQPVrDlwmc4uU93LIFnFOld+4/lacufD54A2MnME/StPHTF3IKrKaROttsBrPAVPj4517JWF8YQWKv6NzNLPHs/xRGlZlSWGOVC22cyT+0PcTevtgQVCQ6LnsfY1bjgSJokRzujlNP8KUon2xfvsgQXvMH+3UJs6o6cBeQRRYW1MNK6C8rxcvRlPGODkvRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QKTuQmlKbZkKWrrCNvkwfwVSciiwu4lpXXbhtlz6B4=;
 b=GwMXh3iOYnXS59sycNs9UwyDt8eHJV0qx05ORIBO62VFuzyMRHJ9ex86wsfmJXffda+n7Vcq6EtyrzihozbN6ErhbXoYB3priwjT0wasHYP+8RD7sgujOrhqhQSXW+5p+VjAe8L5m7dpiAjyFgQmVJnmH4syb0gRCPI5BfIrCUg=
Received: from BYAPR12MB2967.namprd12.prod.outlook.com (2603:10b6:a03:d5::24)
 by BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:63::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 08:44:06 +0000
Received: from BYAPR12MB2967.namprd12.prod.outlook.com
 ([fe80::7de2:5c6a:c1e2:2895]) by BYAPR12MB2967.namprd12.prod.outlook.com
 ([fe80::7de2:5c6a:c1e2:2895%4]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 08:44:06 +0000
From: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
Thread-Topic: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
Thread-Index: AQHWZIb2jxslUMDPT0SH6PZPXOP7C6kdSekAgAAMewCAAOlI4A==
Date: Wed, 29 Jul 2020 08:44:06 +0000
Message-ID: <BYAPR12MB296760EAB2FBAB0EAA032FA893700@BYAPR12MB2967.namprd12.prod.outlook.com>
References: <20200728022929.411527-1-ChengZhe.Liu@amd.com>
 <e9cfded6-af16-0404-ca7b-afcc4a285427@amd.com>
 <d4471f87-9d85-8257-0acb-836e8270ab91@amd.com>
In-Reply-To: <d4471f87-9d85-8257-0acb-836e8270ab91@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-29T08:43:58Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=03f86ff3-363c-4f0d-8f43-000074e484eb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-29T08:43:58Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 48cd4ff0-8561-45ea-b5e0-00005ed5ca72
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b00c06fb-b7e1-4cf7-f854-08d8339b8daa
x-ms-traffictypediagnostic: BYAPR12MB2680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2680FE9D7D151C82C358A5F293700@BYAPR12MB2680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrNkn7TY47CMSUgufiukMYqixGi1sNr5HHHwmX09x6WJfpUquWopnDCddeZcD6dI9ZEsSMaqIYJe23y52dcN4YUK7VmxIxGqmmhTc5RDCmFuW1i44WoPYmVnRonH9JXhkYqHsNNdnsktY5cOOR7o14babhBYSPOAlnx9nFi+j9CYHX7BW7SpP6iTUHQNhJQjXKMKxlvcjOBcQubLdxTQiZ9mInJ945FIe5KOmnFr42P04FIlLiOJNpY+v2R4SEjA6+BC/WiwKxbAPSMz154zdnaZ0RN7HsCN+9P9i7fZyRQoIe2ZNvLgYZG9rmpaoEA41oGRd8G3OqWzOH2+mLEPJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(5660300002)(7696005)(110136005)(6506007)(53546011)(54906003)(86362001)(52536014)(83380400001)(55016002)(316002)(4326008)(76116006)(2906002)(478600001)(8936002)(33656002)(9686003)(186003)(66476007)(66946007)(8676002)(26005)(64756008)(71200400001)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WE7zSGOvNJ+06RCRY0cITIPnbmKN4m6eFLqTP84thGx1+5GhyHC/4JECrEBHBYCv/LiSe2M8yUnTMggK0ZpDFeFEDHfxprlBjQk2FdtwQGrRGU8Yycmzrn41PnHFGZtpJpV796QMtKiyWm0/wAqmq8RPh3QK40eQ4zN3y97raw4qj1gHc3y8yVy/+QQMtnEazQr6V9Vx6JJTEw2ve9EJK/iERrUSiRlNrZw+9FN0R06J/QMvzbxz9p0zxzp+ZJTS0MDjctdrI3ECR8MRkiVWfmmxL9pUaigWd0bT24ZGPpo2k1+Yme+ACIKoHTzVQvlIZhGyW5+cQovicMT3u/VThU5WgEB2MqRwvac2YOEWp+Zco1Rh3iVOS7HDfoVayYlvdMWeAEOZE6Hs0se05U6l5fD8jHZIidqJFjSeLkj2aLGIXAzo4h7nXJHJEAnd1rUVffl21/pIQ7BzhViaWLciQC7BU3I7VJj1GMxECqpzHKBkuVdTW8/T4WtVzAObgCs7
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00c06fb-b7e1-4cf7-f854-08d8339b8daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 08:44:06.0885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reT/wXpx5F/TKHGn7lk+H/GFUrQoGIyA0CSd0Q3jwm6YQ2UWhdyliFoRvEq9UB1PzmNqahpcqHc67wnvAv2EWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks for the modification!

-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com> 
Sent: Wednesday, July 29, 2020 2:49 AM
To: Liu, Cheng Zhe <ChengZhe.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR

On 2020-07-28 2:04 p.m., Luben Tuikov wrote:
> Thanks for removing the braces.
> 
> On 2020-07-27 10:29 p.m., Liu ChengZhe wrote:
>> the block->status.hw = false assignment will overwrite PSP's previous
> ^^^^^^
> You want to start a sentence here. Capitalize "The".
> Also don't use future tense in commit descriptions (and commit titles).
> Simply use present tense. Using future tense makes it confusing if 
> this is what the code used to do before this change or if the code is 
> doing this right now as someone is reading the commit in the future with "git log".
> 
>> hw status, which will cause PSP execute resume operation after hw init.
> 
> I've found it best to describe what's being done as if telling a story.
> Break it down into "tell what's happening" and "tell what what's fixed 
> and how it affects the rest of the system". Something like this:
> 
> 	Assigning false to block->status.hw overwrites PSP's previous
> 	hardware status, which causes the PSP to resume operation after
> 	hardware init.
> 
> 	Remove this assignment and let the PSP start when it is told to.
> 
> Check if the above rendition of your change is correct, and use it if so.

Double checking now, since "resume" is an op, you should capitalize it.

"... which causes the PSP to execute Resume operation right  after hardware init.

 Remove this assignment and let the PSP execute Resume operation when it  is told to do so."

Or something to that effect.

Regards,
Luben

> 
> Regards,
> Luben
> 
>>
>> v2: (R)remove the braces(.)
> 
> 
> 
>>
>> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 62ecac97fbd2..5d9affa1d35a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2574,6 +2574,9 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>>  		AMD_IP_BLOCK_TYPE_IH,
>>  	};
>>  
>> +	for (i = 0; i < adev->num_ip_blocks; i++)
>> +		adev->ip_blocks[i].status.hw = false;
>> +
>>  	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>>  		int j;
>>  		struct amdgpu_ip_block *block;
>> @@ -2581,7 +2584,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>>  		for (j = 0; j < adev->num_ip_blocks; j++) {
>>  			block = &adev->ip_blocks[j];
>>  
>> -			block->status.hw = false;
>>  			if (block->version->type != ip_order[i] ||
>>  				!block->status.valid)
>>  				continue;
>>
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
