Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB5FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 06:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B1111A632;
	Thu, 19 May 2022 06:00:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87C411A632
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 06:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE/EVeKfRkEKJCEAH43k5SAGI6ApCH4R1T815dnMO8D/122zDCO6jMlG6MSP/shuqc1vI74Ppe0dqNCoOZuK1E0vmDXrgsE7Noj/4gG5/sJvT+ZpdGhPQ1vmlYu/ZkbmXS/SYnOp8AsJbrjFfF1ygJJbcWOyR2P/5AkOriLxKNg5ZgCUOQ/SaYfTbDw2j20gLJ1+HvBr8hg/Di5bL11QFs2ZJgt0Kl1tS9uzJWv7Q/Mfrg8+smto//h7D5E9psdEJX1pNNWtL3Ipk3WLSAPIR6oPesaN3Y4qOWBtK8LsGsAy36tacs7PSTH+dWSsx+9RABKTysm/fa9RH/jaro0qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUQLdludDVMet8RyCMOj49oxdCFQbiWCTtUFN7HK83Y=;
 b=YqYWqNtKC+/WavW+a/bN+1j/Vfvt8020vNH5gNkz7MaiZEcbACngQrSt7YEi7eU8xHWVDdhZWFigTDn5Cvwm6VwAWwSGIUpAGGVGTZ2F+UdUBO3Wqeo0XtTRfeE3al7suTubL32i3t0QZarbfTsB4yYLPxOGWduwBD6xmVh/sVZSDFvLjj3c8QUfBJpbBq4MfZd8pHHMZkiXN9nzMbqiRGeF5FYnwKMeftDojS+rLSX8BoxzuD1jW2MC21tr++pFVy6vZXjoLodt5CUWBcic9XTY2JXkK3S+r9QIS2UHSEdIekeKM1psqiiK5SnIO0uYRQm/2tJkV+YG01UAelIOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUQLdludDVMet8RyCMOj49oxdCFQbiWCTtUFN7HK83Y=;
 b=wk6+TG1RN43LhK0S3JSFxC+LEmiw6V7JpRTW2cRwuepWZ08r/BIxzwoJ0tEDLFrRqOmkKk2gJ7tqTTYRT1iuSIVpK+z8DJJVcJ7t/Ogn/ELaP+dwTYJ/JSzAoCqu4Mko/MmipHaKtp5yJh+OwTmTRW/M3U8VoJI2tcn9aiO8uhs=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Thu, 19 May 2022 06:00:32 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::d914:5c84:26fe:45ed]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::d914:5c84:26fe:45ed%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 06:00:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Fix missing thermal throttler status
Thread-Topic: [PATCH] drm/amd/pm: Fix missing thermal throttler status
Thread-Index: AQHYa0FLFa4NnLHvP0SKWjryIXVJOa0ltKlH
Date: Thu, 19 May 2022 06:00:32 +0000
Message-ID: <CO6PR12MB5473C2DF6BDF93655F61202082D09@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220519052803.1408304-1-lijo.lazar@amd.com>
In-Reply-To: <20220519052803.1408304-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-19T05:59:21.6156526Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c08b4674-d848-43ec-0c68-08da395ce26a
x-ms-traffictypediagnostic: DS7PR12MB6021:EE_
x-microsoft-antispam-prvs: <DS7PR12MB60213E860D94CFA06575C93582D09@DS7PR12MB6021.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGAetIywmz7x9Twq2M2yc+FmzdpSXKQO/J3BCid+HQP7Zb/iGyk8pvqpQHXiFKF/q1PC4E7civj2vyv12vdzCMYD5fjKelMQxF2rAHxcbQhwDOwIySNuNX8tOhcWslpwlJtcswZ+EJB37dl795rpnzmx+PFfw3sFkFRbBWjLCax2R3/3LO/b9qpFroJAbjAnjNO4uDrdLGyRLPhY4bTTWEF1uFAybHdCv+HeSQ4VoKmvfGgd8dP9ojYaCB+peowMPkmKk1PTrO/FBnrfVf4InKoKuhdFm9O18uPOfIpwM28Jg0uw8yFwTnDVN5LyhC5dT2sezE28zqhjvaI48vaXsGPVPzyDGNatf8+5GeJ3ZOWz1oBIqyrqggQW6nF8w5sLfRlr63hBupcBqIkhTH6tXSU57nypbkWoMOyc/ZGjGWZ6vAxRJea2rMqSxapKfl79M6SFrbU8VGQ+mbKqHs0h/RBsFObYriyV/X/W0xARqC+hKLFXFnp391HXzlNGRsqMk0y7u/mvWja7DqIAgT16hL2QemgejWpO5pdT2OR08xuOb4PRnyei0xk69sRY9RrDOKvfvxfTjB7cUIKTymXBjNUuwz7NqBqaug6KeM5YrJM8/vnh18QyGo7/BLcGLNveGuNgM0nqpEA2UXLimm2e25jfoq3YXta+tzJUqIf8HNMCxBxE1Tjx90wBvTszhj+8M7GdDtdA5wdZu4LMhjB8Eg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(83380400001)(71200400001)(6506007)(7696005)(52536014)(508600001)(55016003)(2906002)(5660300002)(8936002)(26005)(122000001)(86362001)(66556008)(38070700005)(66476007)(66446008)(38100700002)(64756008)(8676002)(4326008)(9686003)(186003)(76116006)(66946007)(54906003)(316002)(110136005)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?elJOamlFVWdaN3o4b0M3YzY5U1JwYkhTUzVuRUhNVEhlWWR4V3hodzJYVGt4?=
 =?gb2312?B?cnpIcUdkSmgvYTlYUmR1YUpVRWN0QXJacE1SRmtBRzlZRGgrYkZMWHVSNXhz?=
 =?gb2312?B?U0RxaEpMZ29Wc0NISmp3dnIwZVgxMTNrSWVKbmtpbVdyU0hzVVloa0IxZHhj?=
 =?gb2312?B?dWtELy9WUDl3S0IzYUNGcFl6ejNDdzB4WG91K3I2ZCt4Si9qYTIzK3ZlYm01?=
 =?gb2312?B?VGlLZVpQd0d1L3ljak9kZE1xSGdUb29lK2NPYmMrUW4vSkZST1NCYy9mWHl1?=
 =?gb2312?B?RUdGOEF4OTNIWVFJekFkNWE2TDRiMklVZlU1RnhPWWpMYmVWbk1rYlBqUWg4?=
 =?gb2312?B?TU5JaGZKUGpWY04zd3orQ08yWkgrUzQ3YTV4NW5za0RWMVZxU0cyOFo5cGdh?=
 =?gb2312?B?QTlocGkvZEFmenBrcnBtcHpKamlZMzJPWElUM2FOSURYd0trS1EvREIrVHFY?=
 =?gb2312?B?c2NSY0JwVkdZQVN0TWdZcUozTGdPZWZaSmdBa1lVTUV4UDhlTGpCK3NFcy9F?=
 =?gb2312?B?ZU1KMlc5Z3Vwb1BFNk5Valc1dFBXeEovUGZJUll0VUM1ZUJHb3M2VFhIN0Fh?=
 =?gb2312?B?M0NSc2pCamJuTnQ5ekgySWdMdDdEQ1BxWllYN0VKR2RnZGUwa0g2OTZleUx5?=
 =?gb2312?B?RVZOcXhuSXpXd3ViNkxMVFFYT096L2c3MzBzWGlMRHZ3OVpKbnVWaVdMamMx?=
 =?gb2312?B?MURCWk85YVV0c3A5Ris3MkFXMUJjdGRDWUtORjFYdmxnbXZuOVVmMzgxV25h?=
 =?gb2312?B?WXJiQTdud0RBTHRrM2gxbUp0eis4dWxWN0s1SVhsejdTNTQzaVVvZFBkOEV1?=
 =?gb2312?B?a29sVngwa3NrQi9YTzd4NkhOcWdzRWJqQmpjUCt2Q0xDekVxRVZycjNmNmNR?=
 =?gb2312?B?NVhEaWY3UEVSSVhxTEpmbDRReUc5R3NrKytTMkpSUUt0TlFTcVBQT3NQZEZU?=
 =?gb2312?B?N0gwSmVKQjJUdXZlVlNjVDFmZ1h6Y1FaNmdRWkVsenN6UTlYM0JFRlphN3FM?=
 =?gb2312?B?OHpoZ3Y5YXU5cVhsUTEyUzYySjh1RmUrWUFDOGNNR21jeEI1bnJXRDJwU2tU?=
 =?gb2312?B?d29WRzV3eEU2NGlLbUlvKzhNL09LV2dTSElUejZSenRJZkkzOUJoRUZRVFla?=
 =?gb2312?B?bUFyYzlKWnZ3U3pRb25DNTBVd0labFNGTTlXV0xVcU8rMVMvTWdqcU9qZmpD?=
 =?gb2312?B?NFZVMmZyZGhLNktBb24xTk5oZ2pOZS81Q0JvM1hyeXlPbkVQcFQrOC9kckFH?=
 =?gb2312?B?WFZLc3dMNXVtS1RQSTRmdUhvVkx0dnFPYzZDVlQzVVpCQTVKSTBRa1V6YzNK?=
 =?gb2312?B?bGZTRzNUUUgzU3hWWENVRnhDbzN1a2ljR3hKeENMTkFLQjBsV2hVTDBHakp2?=
 =?gb2312?B?elV4OUpCRCtIZXNaOEp6OUphNW5naHAwMG4rWHAvVVA0eUtTT3FPbzgydStL?=
 =?gb2312?B?S3Q0eVVpcjkxWmtoYkgxNG10Y0ZjNDZqZDZpdk9vcHNIRHo2aHd4dlNTRVNP?=
 =?gb2312?B?aXJyOUdpeGxqRUs2WWlHYlRLQTAvaC9IVGZIUFRNYzJvTk9XOUVIbHdNT1hu?=
 =?gb2312?B?N1QzcEoyMXNoT2F1SkRYVjdRdUlYZ0E5K3IzbjBUSnVKNFUzOGZKY1JhTmFC?=
 =?gb2312?B?ZnU1WmZsVVVNS1dvSlRFdzcyT04vdDdsbjEyUXlKcFdlUEhkVk5tRUdFVHRm?=
 =?gb2312?B?Rk92QjkrRHQ5ZHJWSFJsY0dSQUlYaktvTEg1bzY3cWF1YW1qU1EzT1NlWFpI?=
 =?gb2312?B?RWkxaGErckxvQ3NTUSt6bXovbUwzZm5pWnp3TFZjcHBaNDZlVEJjL0JZcFR0?=
 =?gb2312?B?L2RWcmhWeGM0WXk4dnJ0UXR2MkY5Tm1qaWprNk5EZ0FLTDJ0RGFONWQ5SUho?=
 =?gb2312?B?amFYcmtpeDdiL3Y4SnU0QnFPeWl5aU81UHhhTTlEZitjY2NWSmVVTjJEUERC?=
 =?gb2312?B?OTcyZ2VIWE51a0Yxd1ZPQnZDRkE1Q2xoNTN1N3o5SXF4NTJvU1lUNVNWeTZn?=
 =?gb2312?B?UmRHdFZkQmE0RjJFa05xK1VSeFZwdTBZb3RKN21hc3FSWDNqZjhEeFI0NEZy?=
 =?gb2312?B?NHZqQm9OUlBGcWVXRWdhMWxjSExFTnNTRDN5dWhsQ2R1WDZBODFXdGRhUThQ?=
 =?gb2312?B?TUMyeFRBUi9OZHYveTJ6czY5U1M1QXRrdnlXaUlaWTIyaTdJMnY0aFVBQStW?=
 =?gb2312?B?M1lBdlRNTU1waU92Y3ZxbkpjOWFKWmtHM2U2U25aSGF4cUJsbVlzUWtSOUVZ?=
 =?gb2312?B?S3I1NWNTbk1OdFJKbkthbzdDR21LRk0yelB1SXpXbVltdk5KU1l4TFprVERn?=
 =?gb2312?B?ejNPZDJtNUxwQkVKNWw4cFdBcjcyV1l0K0xreGszZDJMek9jZGJaQT09?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473C2DF6BDF93655F61202082D09CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08b4674-d848-43ec-0c68-08da395ce26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 06:00:32.4409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ra2Fwrkd4Cd356e6/qBAZUbWjhdU4heI41hG5kXEN1eVTJCF9A95+QZdfglmya0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473C2DF6BDF93655F61202082D09CO6PR12MB5473namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5IFlhbmcgV2Fu
ZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCktldmluDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiC0+rHtIExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNv
bT4NCreiy83KsbzkOiDQx8bay8QsIM7l1MIgMTksIDIwMjIgMTM6MjgNCsrVvP7IyzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0K
s63LzTogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCtb3zOI6IFtQQVRDSF0gZHJtL2Ft
ZC9wbTogRml4IG1pc3NpbmcgdGhlcm1hbCB0aHJvdHRsZXIgc3RhdHVzDQoNCk9uIGFsZGViYXJh
biwgd2hlbiB0aGVybWFsIHRocm90dGxpbmcgaGFwcGVucyBkdWUgdG8gZXhjZXNzaXZlIEdQVQ0K
dGVtcGVyYXR1cmUsIHRoZSByZWFzb24gZm9yIHRocm90dGxpbmcgZXZlbnQgaXMgbWlzc2VkIGlu
IHdhcm5pbmcNCm1lc3NhZ2UuIFRoaXMgcGF0Y2ggZml4ZXMgaXQuDQoNClNpZ25lZC1vZmYtYnk6
IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvYWxkZWJhcmFuX3BwdC5jDQppbmRleCAzOGFmNjQ4Y2I4NTcuLmZiMTMwNDA5MzA5YyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFu
X3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJh
bl9wcHQuYw0KQEAgLTE2NjYsNiArMTY2Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGhyb3R0
bGluZ19sb2dnaW5nX2xhYmVsIHsNCiAgICAgICAgIHVpbnQzMl90IGZlYXR1cmVfbWFzazsNCiAg
ICAgICAgIGNvbnN0IGNoYXIgKmxhYmVsOw0KIH0gbG9nZ2luZ19sYWJlbFtdID0gew0KKyAgICAg
ICB7KDFVIDw8IFRIUk9UVExFUl9URU1QX0dQVV9CSVQpLCAiR1BVIn0sDQogICAgICAgICB7KDFV
IDw8IFRIUk9UVExFUl9URU1QX01FTV9CSVQpLCAiSEJNIn0sDQogICAgICAgICB7KDFVIDw8IFRI
Uk9UVExFUl9URU1QX1ZSX0dGWF9CSVQpLCAiVlIgb2YgR0ZYIHJhaWwifSwNCiAgICAgICAgIHso
MVUgPDwgVEhST1RUTEVSX1RFTVBfVlJfTUVNX0JJVCksICJWUiBvZiBIQk0gcmFpbCJ9LA0KLS0N
CjIuMjUuMQ0KDQo=

--_000_CO6PR12MB5473C2DF6BDF93655F61202082D09CO6PR12MB5473namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div>
<div dir=3D"ltr"><span id=3D"ms-outlook-ios-cursor"></span>Reviewed-by Yang=
 Wang &lt;kevinyang.wang@amd.com&gt;</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr">
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards,</div>
<div dir=3D"ltr">Kevin</div>
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>=B7=A2=BC=FE=C8=CB:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&=
gt; =B4=FA=B1=ED Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> =D0=C7=C6=DA=CB=C4, =CE=E5=D4=C2 19, 2022 =
13:28<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; =
Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amd/pm: Fix missing thermal throttler stat=
us
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On aldebaran, when thermal throttling happens due =
to excessive GPU<br>
temperature, the reason for throttling event is missed in warning<br>
message. This patch fixes it.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
index 38af648cb857..fb130409309c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
@@ -1666,6 +1666,7 @@ static const struct throttling_logging_label {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *label;<br>
&nbsp;} logging_label[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {(1U &lt;&lt; THROTTLER_TEMP_GPU_BIT)=
, &quot;GPU&quot;},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {(1U &lt;&lt; THROTTLER_TE=
MP_MEM_BIT), &quot;HBM&quot;},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {(1U &lt;&lt; THROTTLER_TE=
MP_VR_GFX_BIT), &quot;VR of GFX rail&quot;},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {(1U &lt;&lt; THROTTLER_TE=
MP_VR_MEM_BIT), &quot;VR of HBM rail&quot;},<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CO6PR12MB5473C2DF6BDF93655F61202082D09CO6PR12MB5473namp_--
