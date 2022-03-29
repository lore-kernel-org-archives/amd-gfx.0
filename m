Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B87BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 13:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2242A10E89F;
	Tue, 29 Mar 2022 13:18:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57AE10E89F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 13:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N78ZD0XjoAKTJg+MvOKFkNXIgKWI6G5pwoITKYsSqXi77qaRypV7Y6L+rrSZt6Eiwef7YG02TCSl8m4tBOKXUfcizf1VL3XURFHN0B9SujiuuUg7Kk8QM8Wt0LInMHxLf/asVTG2IdMoitQ7+NLVPhd1NpVDy9/iZp0Vw/SwtBmnYOEVJFlFA+51eIfqZrNEeey3Xm/CeT+SaFaPxYeecI6SSoyB5kEb15hzVU2XppcUMoirlIjLc8Bz9DSEfpOOJuZc/FA/XCqCpsd3MGuw+JGlBr+kdGxGKUN/68zAAsmMGuOK6hKvgKfnqZJyNdv8JON6Uo8zxFJkrKyImZCiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6VY0MSxbEb5xERhoZOG58qu+yaqiV2yKuz9ZfYThm8=;
 b=d8Mlp5Z10b0Wjoc/Br0ts8UUaV9e8X66JpRJ0y3Jjq0hXMj6Fzx0K77CuJFybXIsz4KeN6ZWMjfGN5ipLqliwScwQW5wwyfx6RoXm63/HkYgOQM2sR58SLAupJDXh4T2d1tBDCSIr8Wun25HuIPPBasqLCouOHUeWT0cn2PYkhIEP8bssDrzGE4vxSLfOLLHzh2C619U1QE6xTeaKveMPCYKPYQz2wKtE85/ync4DxqMvm6szv6wlz+h3GQoboW7p2SAmf4Y+P55UU/QPXWOYCXTAhZXncMsVqcWuY5jIQ9Ca64Nolm1iGolxz9jb2En0pT6Ed5d2uCvzOqS45xB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6VY0MSxbEb5xERhoZOG58qu+yaqiV2yKuz9ZfYThm8=;
 b=CgHgUGGisVsbo+i/rRjz4idsTX6w1GPlMkvvUj8cYWbsX9F/pbH/+W/4r0lSEyO6qoWhdXNouYv6mH4NEVSJwcHG9d0zH0IRNRdIDja6WPJXQiKMzFtNbkZMUXjGV+qTUYmzsOfxDA855c/41Gx9wj8iUPmrVzaREe1T9X6ZDgo=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 13:18:13 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e879:fa9b:6e14:4691]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e879:fa9b:6e14:4691%8]) with mapi id 15.20.5123.019; Tue, 29 Mar 2022
 13:18:13 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
Thread-Topic: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
Thread-Index: AQHYQ0AXd/5AC7GS/UuZDKgf9eZqQKzWCMuAgABPZuA=
Date: Tue, 29 Mar 2022 13:18:12 +0000
Message-ID: <CH2PR12MB4215A7C562267ED64F7FA2FEFC1E9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220329073843.772795-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257F539B80934D112D1D481FC1E9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257F539B80934D112D1D481FC1E9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-29T08:33:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=537175dc-1329-4ae4-a9b2-f75868310e33;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-29T13:18:11Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 5956789b-bc95-477c-9958-c2143536e03b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86315730-067a-4470-e820-08da118693f2
x-ms-traffictypediagnostic: PH0PR12MB5645:EE_
x-microsoft-antispam-prvs: <PH0PR12MB56456968A71570FD32778E4EFC1E9@PH0PR12MB5645.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhF7LL+TVh0Lj6uv7jqCeEuclqkoPL8r+UvhmyVTnZ6AqZq6/t7q8nNgN7JY6yB3nOZ6oprm/D1o5YXt1UCUQ1uLnCOESLKDW+NL5ib4yFbsdWsqNZStpyZIP/ZI3TFTwRuXfbH6/7KSAr7ho2Z1LHhcFw+PyVQGLOcM8YNjstFkUkB6tYw5+wNLxthVOCMbDcxAjhCsi9d44RaTao8hLbs4Fyykg5U9XaQ3LpAnJvNs7n3xJ3cMsL8P2sGJO/vuBK0IYi3emPaCvbydePG1aMJQ4fwvuMBcDcMY+bJBgMukHxVlcrC7cF9EzH4OYyOg/BrbmkQR6EUnE7M10XdGm5QV3HYNg+9Oo7hGZMNUMNJ2vOTwYfbfP0PGtoGFakB294x0XppgXa0Z8cIMFuSGLuaKV25NT5lhwZu3LrSBh7TeQWjApElXMh6mHalRTZmartI8YVqEf1rbBkopt9hKmlLtj/Qn1Uo1konnIk9o1vR6qONvu1GDs5Y1qd4wihZhHAWTlbAzmyt73PZSKdDIfbUt1QMeicA+a82niW23GLOTBXQ0v33805MjCOIoWNV7+7rZVfd256e/KQge77NhM3aosZvRGjWWEK8gJae8gA5nxuyJ3MW2YF5XeCgY36XuvQ/Q6MIFTbxYDjJUWJ4ygh/esfypHnEmmV/s/8fJwYx0jGPtWotbGNgJoVQk9EPkRHOpywnMz1Ep0F7SV/aQlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(54906003)(186003)(38100700002)(53546011)(6506007)(2906002)(7696005)(110136005)(508600001)(52536014)(55016003)(71200400001)(9686003)(4326008)(76116006)(86362001)(8676002)(5660300002)(38070700005)(83380400001)(316002)(66476007)(64756008)(66446008)(66946007)(33656002)(66556008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MjQ1WWs5dlJ2dVBzYlFjZUo0c2E1L3NkaWQvTzhlUmhQUmVCQ2padlQv?=
 =?iso-2022-jp?B?N1E0RjVPdi9aajFIajg4SU1TeHhVR0NjencrK2pvV01DL3dFR25KT3Uw?=
 =?iso-2022-jp?B?L0FCU0oxYVdoY3A3Nm9LQ3IrRXVLdlBUYU5VaVBwZHhhYjloZDZQMi80?=
 =?iso-2022-jp?B?N0ltcmpoY0puclNjcVNqRDF5dWNHYUVoZDc0RUloYmhqZEJKTmRYOEhw?=
 =?iso-2022-jp?B?NGk0YnA0NWV5TW9mRGQ0RGxUQ0xuaWdzV01EYnN3NnJickpwYzAreFVC?=
 =?iso-2022-jp?B?OC85RDFuMjkxcFVVM2ZmRUppOThTSkFmekxrWE9SUVRKZkF5U2lJbDBQ?=
 =?iso-2022-jp?B?THJaUTVyV2E0Szduc3RZNkJXeFgyU1gzcW1RNnE5ZU1ZVkorWjlPQ1Ux?=
 =?iso-2022-jp?B?S2RwMVdETWZDelQ1VzlzNEgzUG5WL0d5WUN5VTVEUUZCNW9HMDdtU2J0?=
 =?iso-2022-jp?B?ODdzUHJLcXJreFNCb011Ti9ZdU15dlRkVkJGakNKR0J4Zk85b3cwTCsw?=
 =?iso-2022-jp?B?RXBaOXpmcUFxWmFweDNVQXFwUkpzWWNvVzdsMDU3bUw1R0x6THZ3U0sy?=
 =?iso-2022-jp?B?WnNyblpxK292MGwzVW54dGNWVUthQlpoTk1vSDBhSTVTU3NtdlRKVE8v?=
 =?iso-2022-jp?B?RndXYXpkTGpSQktCeDgyRUZFQnhUTDdvREdWRjEzM3I0SDNjKzcrUVRw?=
 =?iso-2022-jp?B?dkkvWDlJWGphZkF6WmtJRzdoNkNHUEZEZEZYVTNRL1ZDeWFEOXB5VFRN?=
 =?iso-2022-jp?B?WUIvTE4yTGI0WEJkU3lXZHZVWVcwWms1TTgveEUveFlkRzFTR1ljRGxu?=
 =?iso-2022-jp?B?L3FZQTh0d1hzZHY2UU5BRDBJaXRTR0pseWc2MGJ6enczZmhHK05tZWll?=
 =?iso-2022-jp?B?WEtYcXF1aFJqdTRudHQwejJiZ3NMQS95dkNGSklJb0NVTm9UMU40a1V2?=
 =?iso-2022-jp?B?alJERlUraVc5ZDJhQmxjZjJ1ZEFpV2ZYUUVlOGxRWDI3ZEVJL1hDSUF4?=
 =?iso-2022-jp?B?UjRoTEZWMnRJWWFmcnhOUmF1OTIxandLZ1lTSS81Ylllc2JjdTYrTnA4?=
 =?iso-2022-jp?B?VXl5V3lHM242ZGdQb1hRNnJXNXJ2bnB0K1IrbXVVcGtLMmhmTHY0QVZp?=
 =?iso-2022-jp?B?THdKbHZLdkU3bUNpU0hOZDd3ZURHeUJJcjUwYk1FaFk2eUFjL1VOUlF5?=
 =?iso-2022-jp?B?QTY1aFlJSnMyaHd3OE9KZDN1Yy90NDhQWG5acHczSmlhY3lYYklPbWZN?=
 =?iso-2022-jp?B?MmRDZTllcjZ5K0tJYzNaa0pnb0xyUDFYRmFvY2dPZG1kbUQwakJYWEQ5?=
 =?iso-2022-jp?B?Vk1CK0xkSmh4RUxSK0VJUHZXL2NNY1RVSng2UXBiMlEvQ3RoTCtVcW5S?=
 =?iso-2022-jp?B?d3NYTmx1VGIxekR2Z3RmUVRMMU85YWY3SEY3VWRqejhuOFJDcjJpZ0Ft?=
 =?iso-2022-jp?B?aHpQOTkzUURuOFpFV1RzR1BMR2MzK2ZNRUNuYUxxWEtJbm9jOXh4ekhL?=
 =?iso-2022-jp?B?QkFrSkFoTHMvazl5R0YxOHdtREo1RHF6Q1VKWUE1dzd0SURsOG9leHVq?=
 =?iso-2022-jp?B?YmIwbFBNdmlhSzRTMVgrUnNUSjl5STB1eWpSMG5yQlRZcjhRUzBORXk3?=
 =?iso-2022-jp?B?UTE2WnZnNHFhTUd3QWJWWmhrbWxZdEVDOEpJSjR4RE1HU04zNDFZdWtm?=
 =?iso-2022-jp?B?b08xMlNkRjVHZGVyeC85SjAybHc3TVl0RHVJT04vZ1NqM2ZiMmRhWUww?=
 =?iso-2022-jp?B?clRsT0dtMXJ3V2laRWNibENBNzJIWWNWTG1mM3UxREZoaHZwYlZUa1Jk?=
 =?iso-2022-jp?B?U0ZEcy9ZZ0R0ZFl2Z1V1Z3FjcDJPUURkcW1jR0hRSUkySmM2d2pVQk9r?=
 =?iso-2022-jp?B?MU16ak1tUzFOQXNXVXNJcndmbzNTc3l1ekxHQnJ4NXljUFR0bC80b1Rj?=
 =?iso-2022-jp?B?SGhETlNUMXlQZDFzREsvazc2Q3NQdGd5bVphRUdjQ2g3WnN2ZGZUcnha?=
 =?iso-2022-jp?B?Y0FndERYamovQW9jSWs2U3dZekJiTUJOb2VIbGxzVXB3bUxyN05iVTh3?=
 =?iso-2022-jp?B?b2xpMzdjbTBmUnZjU2l1ak95OWVlL2JocjhEL21vbmM5MWhEbVIxWldM?=
 =?iso-2022-jp?B?LzNyREY0d2o2YTVPdmZHK3l6TUtvd3BnSkNxMlp5elNKb3BhMmhobXFi?=
 =?iso-2022-jp?B?UTVLc0JIVks1VzRHRW5Lc2VLSjJTVjFzR21OOXVZdGhaVC92RWxWNHl3?=
 =?iso-2022-jp?B?YzdGYlRyUGZPd1E4b1dacGF6Y0tsY29JVDg4YWJhYUltdHFqOHlibVNk?=
 =?iso-2022-jp?B?UzJBbHpIYWFOQzl0SXRWZ3c1R3kzVHVrV1ZpSFhXYzlBaTBBaEs4U0w4?=
 =?iso-2022-jp?B?ajhFaXVuMXZickRyWXNPZ0EzL1lYK2ZhWlE1cUdCTTlQZlF6cmRJOVB2?=
 =?iso-2022-jp?B?Vm5Id0JDZnJ4U3JxWGpUNTU2NHJkdFg0b2hza1piWWh5eWZubkxOaGJI?=
 =?iso-2022-jp?B?MFBrYzB3djE1NTBaMU1PNlhnbWZwdW5HUURFT3BWYTcvZjROMTFkSnZR?=
 =?iso-2022-jp?B?SmhBYTJ1MVU0N1RXckFnMG43azN6c1JWaDh5STVaOC9XeFl3?=
x-ms-exchange-antispam-messagedata-1: 5sGpNuxuYbwRTg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86315730-067a-4470-e820-08da118693f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 13:18:13.0868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4Hb59DiFLnjRwo5rRyPaJEv/THOUPvMgagkTvLYIuYedbk/2l4UlGIUy9vyCy7i2t2ft1P6faIKgx+F1UzGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Sorry for the confusing commit message=1B$B!#=1B(B=20
This interface is only for amdgpu ras tool new function. There is no impact=
 on currently existing tools and scripts=1B$B!#=1B(B

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Tuesday, March 29, 2022 4:33 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface

[AMD Official Use Only]

I'm not sure I understand the fix correctly - It seems to me it is trying t=
o stop user/test cases that initiate error injection request back-to-back? =
But anyway, we shouldn't make the change or leverage debugfs for that purpo=
se, and there is no guarantee test scripts/applications will follow the rul=
e as well.=20

I guess we need to identify the root cause case by case and stop the invali=
d request in kernel driver.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, March 29, 2022 15:39
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface

Some AMDGPU RAS debugfs operations like UE injection can cause gpu reset. B=
efore doing the next debugfs operation, the application should call poll to=
 check if the gpu has finished recovering.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 ++++++++++++++++++++++++-  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 ++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 4bbed76b79c8..337e3e247a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -452,6 +452,12 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fi=
le *f,
=20
 		/* data.inject.address is offset instead of absolute gpu address */
 		ret =3D amdgpu_ras_error_inject(adev, &data.inject);
+
+		if (!ret && (data.head.type =3D=3D AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE=
)) {
+			struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+			con->ras_ue_injected =3D 1;
+		}
 		break;
 	default:
 		ret =3D -EINVAL;
@@ -464,6 +470,30 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fi=
le *f,
 	return size;
 }
=20
+/**
+ * DOC: Support AMDGPU RAS debugfs poll interface
+ *
+ * Some AMDGPU RAS debugfs operations like UE injection
+ * can cause gpu reset. Before doing the next debugfs
+ * operation, the application should call poll to check
+ * if gpu is in recovering status.
+ */
+static __poll_t amdgpu_ras_debugfs_ctrl_poll(struct file *f, struct=20
+poll_table_struct *wait) {
+	struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode(f)->i_p=
rivate;
+	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+	__poll_t mask =3D 0;
+
+	/* For UE injection, wait for gpu to finish recovery */
+	if (con->ras_ue_injected)
+		poll_wait(f, &con->gpu_ready_wait_wq, wait);
+
+	if (!atomic_read(&con->in_recovery))
+		mask =3D EPOLLIN | EPOLLRDNORM;
+
+	return mask;
+}
+
 /**
  * DOC: AMDGPU RAS debugfs EEPROM table reset interface
  *
@@ -503,6 +533,7 @@ static ssize_t amdgpu_ras_debugfs_eeprom_write(struct f=
ile *f,
=20
 static const struct file_operations amdgpu_ras_debugfs_ctrl_ops =3D {
 	.owner =3D THIS_MODULE,
+	.poll =3D amdgpu_ras_debugfs_ctrl_poll,
 	.read =3D NULL,
 	.write =3D amdgpu_ras_debugfs_ctrl_write,
 	.llseek =3D default_llseek
@@ -1837,6 +1868,11 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
 	if (amdgpu_device_should_recover_gpu(ras->adev))
 		amdgpu_device_gpu_recover(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
+
+	if (ras->ras_ue_injected) {
+		ras->ras_ue_injected =3D 0;
+		wake_up_all(&ras->gpu_ready_wait_wq);
+	}
 }
=20
 /* alloc/realloc bps array */
@@ -2279,7 +2315,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
 	atomic_set(&con->ras_ce_count, 0);
 	atomic_set(&con->ras_ue_count, 0);
-
+	init_waitqueue_head(&con->gpu_ready_wait_wq);
 	con->objs =3D (struct ras_manager *)(con + 1);
=20
 	amdgpu_ras_set_context(adev, con);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 606df8869b89..aea6bbb71501 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -379,6 +379,12 @@ struct amdgpu_ras {
=20
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+
+	/* UE injection flag */
+	uint32_t  ras_ue_injected;
+
+	/* Waiting for gpu ready work queue */
+	wait_queue_head_t gpu_ready_wait_wq;
 };
=20
 struct ras_fs_data {
--
2.25.1
