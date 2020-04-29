Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6898FC83001
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 02:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A66520730
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 02:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yJJN07Ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A66520730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA93B6E0D8;
	Wed, 29 Apr 2020 02:32:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004366E0D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 02:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJI4G74ZCmV9AJ0nzIAVdCfoOqwMHXFrEuXTIRHvNDT4QC9q8lqBE1f4qfpyh3pO1wAox78AcVhTHfHtJW8yKAOqfyFTzOJTv2lKdN8YwXyWr/YXfrgMSxbFfwBtX1LSCHbaYd/5IraJxxQAYHopq5HAvci+ftrlJWZGaooo6De6uyxaLY3ui70IqO/XhgjKW0sdH8+9ohYmEwGZ43nCXIjAN29MftRs5OBDUWnnyIoCCqLzvM1KpcDSBGJTgGmT8j1FCtvCqwgmmbXv1qLDt9rGm4AUTaL4vZ5azrp8pCamChn/wCyUJ+d4YiGvmpEPYo6xhN51p/IXhpt0GXk2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxsB0/ZTJPrBawBXMXSJSQWInpnDCykDYQb8HxAczBs=;
 b=dR7v09NeDQW/XLwiFRjCXEiAdRDl7DTQ89Nev06ueNWsKootq2d1aoT0CkfeUo6xd8h+OkqxuVzt6xRObP2yD8Lwm+AoK/v+gQKqhhkTFmJvcAGT5o4lhGRPTglVG01HuIIsw47htpXsVOil5zA7hx1woPGb8Oay32C2pgUfZz+oP8ECbOdzm8ISDEMTsyNSQj6KFwnoXPutohXtPQdf5H9lfoPZbe9st6F0PTqE35U6EPDHiTBgT+jhAVYMesgL/IrswEYjmI0Wr5/Z0Q/hwI8XJ6FWlJeLfltJvNIAu5t1Ctp919LtOemT6eWmKPTl+zEXUD2eH5op2foQyUdPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxsB0/ZTJPrBawBXMXSJSQWInpnDCykDYQb8HxAczBs=;
 b=yJJN07Msesqy9q4Jl5/GZWq/8z5GYnvcL9A8GKBDjhIF+jkmgUF3/bCJukltyl8QY8VhKuXCpk4PoSLGAyx5IqSaeXOxlQnvZeVW7Muid5eX+Qj9h03Wg4oP3fBOoUpcW7exMNI/ESnQycsMQdLd1Fedb21N+WYYoJSjE35XuNQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Wed, 29 Apr 2020 02:32:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 02:32:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] drm/amdgpu: address the static checker warnings
Thread-Topic: [PATCH] drm/amdgpu: address the static checker warnings
Thread-Index: AQHWGiTu7I5Scz2wt0yMwTzPRddleqiIG1QAgAKhFICAAxliwIAAjrAAgAEDYqA=
Date: Wed, 29 Apr 2020 02:32:29 +0000
Message-ID: <DM6PR12MB2619C9FF930992B4448D717AE4AD0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200424104115.28738-1-evan.quan@amd.com>
 <20200424110214.GR2682@kadam>
 <DM6PR12MB2619DD18E7E97E62291C1585E4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB261984ABA35E54EBFE1CA521E4AC0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <20200428110135.GA1992@kadam>
In-Reply-To: <20200428110135.GA1992@kadam>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=810d12d0-675f-42eb-8378-000061be75e8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-29T02:29:59Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bdecda34-c5e2-44cf-b9ba-08d7ebe5900b
x-ms-traffictypediagnostic: DM6PR12MB4300:|DM6PR12MB4300:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB430017A0742CAEC1DD0F8817E4AD0@DM6PR12MB4300.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(7696005)(478600001)(4326008)(53546011)(26005)(4744005)(71200400001)(33656002)(6506007)(5660300002)(186003)(54906003)(52536014)(86362001)(8676002)(9686003)(2906002)(55016002)(66476007)(6916009)(316002)(66946007)(76116006)(8936002)(66446008)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKNPeUYIHdVC+yMgGuKsNQTse0lvFgmJYDyPn3h0xiSPGCcy1cWKS0oJj8f+8jA6xASqnViKDvoPMawCw4XMLbJp5TVFcKLsSNwwXQt7j62jcC0tpc2aqJUvC5rnhbjMxdpzIVGjwgEbExY/Jvv8cfmx/ZUWYcKle36S18CAAKyr9v1RX6aLehebC7rfV/8ZB00FkCA63jwHdEuLCvSNfVXeQvgiqRaBw/Tcw/LittArqQKK8WmPNe+oiVBPSY2SS+WwrKTv3YUXJllTARJsbhQ/DLYPtJ6wqVpB03WVu9EUsXe50ZnLp+d+oAIHWqFqnn545WbcrW9AWfy6tvad2qkyIW03CzZq7Gr6TzUdsvVB1BOZ1SKxBMk4ZTUK55uZYiJv5aYdIfG92vka8tYGCrUNq4hsmWRviiG+pJ1npezqsdQLQJgh50wSNQ5ERexW
x-ms-exchange-antispam-messagedata: X16LgWK22UUbIQRDcuZdw7aVUZL2enP5d6Nl4PUvqNkuZTYYGDpG3BDu1JFloWtBL1nXJicuJXy/himbVVP20R1T66qDr4MoW1Uaz+io0CcPAP9CPePQu/tWee1FhjPcg9/2UP/xOtZX83cMDtPdvdCMDoE3h9p0VCwDbp8HPQaytW4tQHQP2c6g50rPj98Tw2Bp8QzEGhPU4PoqL/V0mW5VKtKZKjdLXPtmJUT6lArK8Q2KKuO33GK7iKj/ZMjd4DRuG4/5ffyHbqatiuZNwNmgwXA1DupF6pOaioYpTP7I4lGDIG8S3vQxHLX8EeJS33cJ9FZz1Mz2OHGKeUx7oi/t6sEHq/M5WhVm/9rLv/KrnKtOtaRfXJPLhImOEeQjasqA+VKbRY0t0ufFGJ5jB4ZS+PLAV3EQXaxoAjriiFCArbWJSdguDt5J0TKWbjFE1Pw0Lz7fx9cjK85ecFagaetrAaORHl73eNVfqP82d6H7tPp0qqKyL1EHx0rqAyLN5BOcpKir74qPXxwtlO6G4CCuWZNQ/BPHMEYabNqOQnXnFAfu1FAJZ/fIP2TWB+cmrufXboYVYisYLd22+nlXwoNUd6DxeTNKytFvJoPJaT3EInJ9jWPszgJp1HZzGxAz0WSBtOrLTaC11078qQsraTvBJAJK5GxfTvmM0q6D8kR6Yjs4CDK2Yu5qqEF6ZcvUJNmBzgRU9J8HNg7ngmkTLoB7gYx8M0kXRGuQcVpV7U/4iNu7LvIgYov3dsI1R2073NxSOArQv7pWSAq7IdWhlqSnYZFRoTqE7ebxA0yAgZE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdecda34-c5e2-44cf-b9ba-08d7ebe5900b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 02:32:29.1747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5FTwHBtbB/SpntxqPEaWGw4UpykYQnFXYNbY9zVJ5YuWBz2Gb838G4rF7R46Jq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks, I think I get your point. With hive!= NULL, it never fails on the amdgpu_device_lock_adev().
Sorry for miss that. Will send a new patch.

Regards,
Evan
-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com> 
Sent: Tuesday, April 28, 2020 7:02 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: address the static checker warnings

On Tue, Apr 28, 2020 at 02:31:12AM +0000, Quan, Evan wrote:
> Ping..

Are you asking me?  It's really hard for me to read your emails.
Normally email clients put "> " in front of the quoted parts of the email.  Your email client doesn't line wrap at 72 characters either.  :(

> [Evan] No, that's true for SGPU setup only. For XGMI setup(multiple dgpus interconnected with bridges), the "hive" here is not NULL.

Presumably you are talking about out of tree code so I can't comment on this.  In the current linux-next we know that amdgpu_device_lock_adev() will only return false when "hive" is NULL.

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
