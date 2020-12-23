Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551E0C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 05:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55BB2158C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 05:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55BB2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0754E6E8C4;
	Wed, 23 Dec 2020 05:48:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D64C6E8C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Dec 2020 05:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQTDVXxhmxim/jOXBCEjbc1CZfPRa8kgpE7QQx0u4hjPp3akswf3G/17a18wC9HZ64ZAZOEgGPM1BK6PaSRqiQwocuRCFUFDks3Zdbc1IlQpSpwDFgvw2QYVvViAfxYqfk4GRcBZZstrnd4Jm6axUof+M8PMXvzvDok48hdb28opAHG/sgPKHDhriAqgxqT74dIWSlKEIfjqqW5T6nK92NQU8LZm5q8uI1ahtsKgODS0TBtNzwBhpubpu2HP7uT2yMsGZvmzPeIMwiuIgFgpeQ4NvgWI3OVy61tafYNGy0p9ODsycdstKEZiyFhmWnBYKLsvRrvEl/befOC5rX3CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h43AqLUsbakspAnZC3u+002F6dPSx+cu95c1dOplbPw=;
 b=Eplel2EQ1GY5NSpluKLi1VwrHlUyxnH4PwpfqfXw0r42YR23QKvkcm/Y4VgiKVk7rGYl9a56bSe4RlIbbWykGydkI1KGOJsvwtcb326+CV+UPfrBaGKvcUAxwD8Ne88SYipXw/Lu+yw5yOqkzXmBXQMeKZEyu7itEqhNgUXFbdOUPNng4jTbnM6dp5Z7U4YtqRjamB96BnpV1Sym211VzeGLke/K2of1PptlUxMqNS4a7Xj/it/AaQMYUTeT2qJUL/duBrn1Fmz9B/UohG1zQd0Msgi4th9RCSQn9//1OGaPyZkqaSHG7kfmysGUKZdd96ZRysL1QweaoeYuEDS7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h43AqLUsbakspAnZC3u+002F6dPSx+cu95c1dOplbPw=;
 b=vvziF/rGs/kqwmUTjBDnkKD5uFl95/TWgaf9Y/8uxO/DZedylYwCpBsqd+9sfr6RJC6mkC0sREBMFnM695E/E/cf0Olw8Gr6uCXWKXRNAki1Ed/KgogIZPmtue0hyWt/2pOt/I0609rOvg3ZgkB+0JUCxSY05sLWp/TkwwZ3WuU=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27; Wed, 23 Dec 2020 05:48:36 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72%3]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 05:48:36 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: Simon Ser <contact@emersion.fr>
Subject: RE: Overlay issues
Thread-Topic: Overlay issues
Thread-Index: AdbSl9sxMkfhaFWoRjW4p/7OX2aWMgAIDMeAABHbJ1ABe+bI4A==
Date: Wed, 23 Dec 2020 05:48:36 +0000
Message-ID: <DM5PR12MB46792E5F8DF0F128FF01D79EEEDE0@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <05FNtjCma79AawCUxH3mqJ8sWHmoIXFXhQWW0N_b-mpl7QvuW3JN3AbtPUiR0y1LOf3tLhWFWv8YjuIEvJ3dci9y1EHk_D9a9L1BAyWyxRs=@emersion.fr>
 <DM5PR12MB4679F2B26887B76BC025161AEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB4679F2B26887B76BC025161AEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-15T16:36:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fdbe14bf-82bc-429b-8095-000000e8c469;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-23T05:48:34Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2716fe3d-0322-4b9f-a143-0000b5414032
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f7653bc-9a51-4ca0-23dc-08d8a7066451
x-ms-traffictypediagnostic: DM5PR1201MB0121:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0121E229E865F19C64FBF387EEDE0@DM5PR1201MB0121.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8gpqXJL0JTShXLlIUe1nrUyQQJ9mNflKmC2OcYtmaJakB/Al4UKLZmCyLQ/pRG5VwWHkJmsFyi/JSerXfCehurF2a0lOw3+EoZJf5g4ZvxVJPG4rO2ZhoggL5bcYBt2YegHiLR5Yx8bYdnm/M7nVaYZkP9jcMITD5PC5YJCIdbRjmr3+8bPQsOzuYcMr2oYcZ7XXU0q2ecee2dmtTos0PdXRyIqSgS0ImJdnG+P/PC9mC+f8Or+lUrOGqE1GJlE6JwsUfkJixQS7yrj0RfJ9H3I3I+au61e2c58kj1/bboshNPhO92CIum6Qt6QA/U7OPK6xKulpdbAupSY5gqeSUUdXRkViFwdW6U5RmlMP1JLo1GZXvGD50p301lmz7UmObJ8wfCM3M0eGwDrZ6gmHiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(64756008)(66476007)(52536014)(66556008)(66946007)(4326008)(66446008)(5660300002)(6506007)(53546011)(33656002)(8676002)(55016002)(86362001)(76116006)(9686003)(83380400001)(2906002)(7116003)(7696005)(186003)(478600001)(8936002)(3480700007)(6916009)(54906003)(316002)(26005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Vys5aVRhZEZELyt3OWo3K21ZcUFrSGdmSytqVUZkY0tONTArcDRZM1RaeHFH?=
 =?utf-8?B?Sytsb1oxcytYOFZFSlArUThiN3ljQStYL0xlWlhJSVFPNS9QZ3NuUVFWQ0ZR?=
 =?utf-8?B?MmxZTGIwUVFYL05BdUNPT0ZWUExFQU5xV2xvZWs1ZHJMQTh5Ry95ZWNQTjIz?=
 =?utf-8?B?enA3ZGcyVCtnZkpORnc2TlJWSjVucEVpWHI0cWFReUhJanlsRjg5dWZnc1lE?=
 =?utf-8?B?V1RTajhiOHhCTFFBbHRCRHRCblQxcmUwbHA5b3lRaFN2eFllZXNReWhKQ1RY?=
 =?utf-8?B?TDdCWGJTK3N5ekJVSWwrbVQzNTlIMVI4elM1b3J2NGkweEFpTi8wQmxGMVpz?=
 =?utf-8?B?NCs5NUdyQTdFTzAvWThpdEl4eFNIZ2ZnYnFGcm4yWlN6d3NzU3RoOFlYL1JM?=
 =?utf-8?B?YkRWU3E5ZDBHd1owWnhFTlJ2WjNIa1lBcExpdVVpNWxMNGpVUjlaYlZkTDE2?=
 =?utf-8?B?SnJpa21qR2RCWnNVNVlsZU5OdFh5Y3hqTVpwWDVNTnhmc3JzQStIeHlOc2Zx?=
 =?utf-8?B?NTUrZ0FFZGdZRjRUOVFpc3E2NUZiODdBMktFZXJmT1drdGlXSFdoYnRSMlh6?=
 =?utf-8?B?YTBDVXpSK3pTSTN0NlVTMy9MbEFFTytrdC9HZXNldnVjU1dpTXE5dVh0WDNE?=
 =?utf-8?B?c2pHcER3ZmFDeU1CYTlybmFja29najVWUmp2MTU4U1kxT2NHaHkwUlZrdnZT?=
 =?utf-8?B?dm1uYXhaOWxXWUlYUnUrZi83V1lFcVdwYzJkUVViZWNac1BrNkdkLzdwenN2?=
 =?utf-8?B?RkRUR2ZWdVJQNityRllKTW02ZHpFZDUzckdZUUJONC9UdUF4ZTg0enBFV3JW?=
 =?utf-8?B?Yzg5ZFkwazdtWExFaVUvZ05WZStqa1RXeVpOejhjR2dkVXRVMm5PQkp6SVhS?=
 =?utf-8?B?cGhvUE1tUGVxcUNkM21CbEpONnFyUnNHQmNZQjdUMHEvZG5sTm9aWjhmSk1I?=
 =?utf-8?B?UUNOTnV6UVRZbTIvb1pmaDExU2pWZ3lEZDJEcC85dGxwWndRTXAraFgwVkRD?=
 =?utf-8?B?NEdKZUVBLzM4TUdpeXVDNk14cHFBb2N3bnlaemxsUWt4ZnhKU05QckptTU1I?=
 =?utf-8?B?bU9BVU9CbWtwakFDeFRRRDdXMlNsMFJBRk15RDdKMDNENUtHQTE2MnBJdk45?=
 =?utf-8?B?dW40bmJlZStwSkZlanVYM08xZE9qOFNuRmdjOGxkRWgwYTNSckNxWmVNZnMv?=
 =?utf-8?B?WnFYQWp6WHJ4WkdPcUNaQnlOaVlERjU1QWl5TXBhUnIvR0JLYjFpWWxkUGFN?=
 =?utf-8?B?ZHRMOSs1ZVNkNTVmenhERDM5UktrSmdsU2phY28rUE9aWlpJSE5zQzNtRWFa?=
 =?utf-8?Q?XHgJnTVXrsJvI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7653bc-9a51-4ca0-23dc-08d8a7066451
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 05:48:36.5947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCJxU+V05CJCyorlLzTb7jHs1oSMY83sZVQt5sMulNrub60uJ4vH+0LwpvOQjuaFj6OR3DbU4dsbLXcZ+WV/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Simon,

Another interim update: so far to me it looks like this is an issue if there's fewer than 24 pixels left on the screen when moving the FB outside of the left edge (e.g. with 300x300 FB size, it repros with X = -280). When this happens, what looks like a boundary condition in our driver is hit and destination rectangle update is skipped.

I need to do some more digging to fully understand why is this condition in place and how to avoid it.

Regards,

Nikola

-----Original Message-----
From: Cornij, Nikola 
Sent: Tuesday, December 15, 2020 11:37 AM
To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexdeucher@gmail.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: Overlay issues

[AMD Public Use]

Yeah, but... it works with bigger FBs (300x300). So looks like some clipping somewhere works OK until a corner-case is reached.

-----Original Message-----
From: Simon Ser <contact@emersion.fr>
Sent: Tuesday, December 15, 2020 2:58 AM
To: Cornij, Nikola <Nikola.Cornij@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: Overlay issues

On Tuesday, December 15th, 2020 at 5:09 AM, Cornij, Nikola <Nikola.Cornij@amd.com> wrote:

> [AMD Public Use]
>
> Hi Simon,
>
> Just to keep you updated, I've reproduced issue '[1] - Overlay plane:
> position not updated when CRTC_X is negative' on Ubuntu using IGT.
> Seems to happen only with smaller FBs (so far tried 24x24 and I can 
> repro, but 300x300 is OK).
>
> I'll look into fixing this.

Thanks for the update and for looking into this! Let me know if I can help with anything. Nicholas replied on the issue tracker that overlay planes couldn't have negative positions, so I was thinking of having a look at the SRC_Y handling (see if we can do the same for SRC_X), experimenting with FB sizes and SRC_W/H to figure out what's the overlay max size still triggering the bug. If we really can't emulate neg SRC_X we should fail atomic commits with negative SRC_X by returning EINVAL (so that user-space can fall back to not using the plane in this case).

Simon
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
