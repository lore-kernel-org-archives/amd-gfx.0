Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B089C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 17:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1597760C3E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 17:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1597760C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B35F6E32F;
	Wed, 28 Jul 2021 17:52:04 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Wed, 28 Jul 2021 15:18:18 UTC
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC2A6E1A5;
 Wed, 28 Jul 2021 15:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1627485499; x=1659021499;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GlPawDKn+tgwgVuSiCv2mWtF4ddTrtC2DzvZGqGqL3c=;
 b=SjvL+HvdmTtyIsgccqSkSQ5jnkA2Kkuy+zWxfE7qUBObnE/vd9NfXgyi
 L8PiAo+Jor3ANffpwOuPqk3Y0I6aaUB8SGcRopD9AnRPwUv6a9wVlfJ5k
 DKboattdm0scm15pbOUk4StaoNxzvsRriIH9/G0Bn300zsq9pVcLRpYbS
 hds01NGnFYPbEmuHJFhpVPZaJNAU2Q1RVCzokYtOQIrqdDWWNdHlBMn05
 PkZ+qs12vY9skb8KMcX54aLl1MNe+B8MaUahd+gPnu1Jwry6gneuIH8uq
 EabMKoVvkvBLGFMxe9QjxuxPYXZWVEbgzWf992lp354yYQZ90YDPMwY1b Q==;
IronPort-SDR: UASToKUbgbjKLQ4YAVjXEITdjT9Ms/vSLtGgFt2YbH7wWR0olBK86rhtS9EgwUBPoL8CijW+GM
 KX9YXD8td4k/JcMZ2WXYlJwN1aN6bgpY0cShv/M1S4AW3uoAJphCeH/ydnRTbz7XCIG14+ciff
 pOc4acehH4XsCDmZfDM96RkUr/+8+XpxU6QGPXiTYIg8PwVk5y26XtYBFQSaS/9lL8+LFd1//U
 xvbpcR92VPvdEoaYk9qYz5TmaN9jY6y3ne5CF13dF213eNe+7OcBl0WQcN9envqNM70SzDL8Ql
 rZM+nLBfNr6rJnq1A1ZGdphC
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; d="scan'208";a="130153875"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 28 Jul 2021 08:11:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 08:11:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 28 Jul 2021 08:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5vrU8ythGUbbkXyetLjCjNzccALPeYtjZdS3YSrS5F9/sUZEr+XrhSdebpr3wtdumgs4kQXT9GqNbyL0IxOkN+OSYMxGHcQAYt5DMW2OXKFd9v9zLl26MmdJPHVmmfDCdeyNsfHtqWr4fDJ2CtoScK457ttGGZcHpYG7mHhyiX2dZBKjthNYWSdf/3n5R5sAT2GwhwNV2Kes+rjtLCyk/OQcZabVJTTt0e8kUUzwkOfT013JaA7pWkITFXxSdWlrPIrzSnqRjUWaxSvj51ECc6aMs8xb/+iiZbCfqdN31uRjdbKfyPXnZuG/CgVHKIOgnhthoJq3JxFfZcdZ0Y+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlPawDKn+tgwgVuSiCv2mWtF4ddTrtC2DzvZGqGqL3c=;
 b=Q9oiRtnzrZ/ElWZ7j7t5Qvk7xxbRhB2c9OFLP3t38YvvlO7T9stbW5uuM/TXSZm06Ca+HDIuOLWbf0hxGNfhG0In8OQN2VEb+AkVn9vAo1zv5bUhS5soI6C4PpOYh/CG13uubwV2HSNcl6uobBe31LPUlzqFz2BID6YAxzDcidt2kpYCdRWRgoo5StSGWa02tUxvCGE/bUOcvkHCVJUcHlmO8y6mO6b40anPih4ZDIMlVsSld7RV1iDC7tfJkkHXr0cEgZayLIz24LGOXfev3ac3yvvrI0LnQKms8lqPhB+6CIRux4LP9Po/0SI0UGWIhR98Chcv4qIjoCLRmpuN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlPawDKn+tgwgVuSiCv2mWtF4ddTrtC2DzvZGqGqL3c=;
 b=Xa37YYQoZkU6VHSJdX9FtH7EI9WGkkifJcUbNsbESm8OMfQUlZVqUvpP9e/dQnz0rJX9N/xI9oQ2t/iF4sjVA4ovAqcu0EHLRIjOsyL7AB7soFWTjKIF5dFEDiU3b2JFRV0zYDSUnfFiVZQbxXUOsdV8vZrXdHnA9VIoEWqvXvo=
Received: from BY5PR11MB4007.namprd11.prod.outlook.com (2603:10b6:a03:189::28)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 15:11:08 +0000
Received: from BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::e478:6b2c:f71e:65bf]) by BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::e478:6b2c:f71e:65bf%5]) with mapi id 15.20.4373.018; Wed, 28 Jul 2021
 15:11:08 +0000
From: <Dan.Sneddon@microchip.com>
To: <sam@ravnborg.org>, <tzimmermann@suse.de>, <Dan.Sneddon@microchip.com>
Subject: Re: [PATCH 03/14] drm/atmel-hlcdc: Convert to Linux IRQ interfaces
Thread-Topic: [PATCH 03/14] drm/atmel-hlcdc: Convert to Linux IRQ interfaces
Thread-Index: AQHXg7j3kajdLBgx2U2WcmMzDSjJJqtYfiKA
Date: Wed, 28 Jul 2021 15:11:08 +0000
Message-ID: <e28b1a2f-015c-c81b-eb64-5323df9ed35d@microchip.com>
References: <20210727182721.17981-1-tzimmermann@suse.de>
 <20210727182721.17981-4-tzimmermann@suse.de> <YQFi96yaYbTG4OO7@ravnborg.org>
In-Reply-To: <YQFi96yaYbTG4OO7@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ravnborg.org; dkim=none (message not signed)
 header.d=none; ravnborg.org; dmarc=none action=none header.from=microchip.com; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77373543-5365-4973-81d8-08d951d9edad
x-ms-traffictypediagnostic: SJ0PR11MB5168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5168548BE43F7F3E73EF44E0E1EA9@SJ0PR11MB5168.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pbvmu+fvCAn8i9D1UIDU7t96ABcCdEWMJp9Gn1oTaxIOmxKv45CjG/UZeNQ14rGClF5tQaT0OUA8+Ihpxc2KKHVJP4gidzCyME256SXl/2bBktjrnBekKSsIG00JXXgsAYobFsQt1aO7PWEjs16aXHM8938mIGI1qITMii/WIM9C3kwOESQpPtwE4blKcJsQ/RWKDgFNDAgLuuTT5ObN0RO2mEDpmJBSOeZQaGphebLvEetowqsM2L9wI/1X+QuWYSV2n4vvhnSVMJdEA3wG0isfnd2IIY5qN+xzfCJKQWTA/oec4Ipm3artGgZta/iUD5jwKHL3vELNwq2xptMOByT2vq+AhoFnTM+I4m6rOohal+/GzKhlSA6g6b9HPn57w3QReZcJLtx3x/2e8mxBQH10GI0FtHOQu3FuYxFoDnAoiVQwWARqZx0Q+7UbBoq9wZY99JGBPvSdvJIasOakubCK7pjrCQYUPR4ND6raHFphv0XUDMBAPIodzYXepta90gZRn1tUBYv1MloqIvP9bSaD1/kPKAk2XCIdF4ZTj3eJ1PrSKrfmWKqri4shBet4g88xikL13bY8FCF6onNSDoqRlovrYNC2dfRUtQDxukmLpyQfbyOLNipDb0GQlJV+nHUCusI41bribNuslUV9NScU5xjV3qyI5FOdTFhL+UVllTAWJ1SGviwC4Q7FnOqWyKYj+ctrCTD4L0ZyFwG55nY6R+IbaFcSSaob/G/8BFRQMJtnhpO8GQxUIN2rjnoMR8ppyByNHMsu7o+enxub+RL3oJdrYqhdIsTzxlbhflRog60XSrpGdeZX5DewVXXF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4007.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(53546011)(5660300002)(7416002)(6486002)(8936002)(26005)(186003)(8676002)(2906002)(36756003)(31686004)(54906003)(6512007)(316002)(966005)(83380400001)(66556008)(71200400001)(122000001)(64756008)(86362001)(6506007)(110136005)(66476007)(66446008)(38100700002)(31696002)(91956017)(478600001)(38070700005)(4326008)(2616005)(76116006)(66946007)(45980500001)(43740500002)(10090945008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmRKWUtvd3hUTytOZ3JvZnl6ZUVxYjJ0MmRrcEZJU1dWdXlVVnZyZnh4NEs3?=
 =?utf-8?B?YlhkdFZ2MG1QbmFkVlJuLzhtWFB0ZE43bjRqOXZ1ZlA5NlFTWU9vSDg1Rmtx?=
 =?utf-8?B?aGdBWlZHN3pHVm9YSWZVaFZMREFKUzBEUTJRM1o0LzZ3Q3l6Q0tzV29zYVNZ?=
 =?utf-8?B?emdIYkE3OGtNUEl5eWF2MzdtRDh4bzBubjIxcjJaTExOaWRGQi9GeWJoVmEy?=
 =?utf-8?B?akJobzJ6V2ZaalIzL2hEKzh4d0tvWEFUMDYxcE9VZGEzSE53SVQ3TTNqTWRW?=
 =?utf-8?B?a242aHRzblFNTjJkRmpjYjZ0eW9sdWNUb0plb1VZQ3FLV0NrWHZhMjlUMW1J?=
 =?utf-8?B?b2RaeENOajFYTUVJWkgrNUFrNEhnSFQxeVhDZ3pLSTRqbzBlM0ZWNWN6Qk9x?=
 =?utf-8?B?SVRZZkNrWFN4Zmg1UEFTTlAwRWdTZW1nQy9tSlZjTDdrWHMvaXVRSExOOVA1?=
 =?utf-8?B?U3ZPMVFJc3dkNTllTGdzTEpWS3ltQ09vbWZKVzJTUFdZTFg4ZWEvZU5mNlBo?=
 =?utf-8?B?SWZacENZdTN4TFNhNG5zWTZpckFkQkw1RFR1ejJ0ZDZIWlJhV1pjSExSeEhF?=
 =?utf-8?B?YUxiblFuVnIvY3d3Z2JGSkdoTzRRSTdzeXhHdTVVbVZEcE5aVlMxeE1Ua2lN?=
 =?utf-8?B?Nkp4QVhTZ0VWTzd6ODVVZU1kTGlmQ3hkZ1YzVGloYy9aNXJWWXFNZkhXazVP?=
 =?utf-8?B?Rk5LdDhXRXdtcUVmcTRwSkVkUERhNlNmcU9Ha0NLNkJ1Y24waVBMbTY2eVlS?=
 =?utf-8?B?NXdXWWhjOGJhM29rbzdBTitiUG5vS1FxMXg4cy9Nck9DYnk3YnBKSThxS0NO?=
 =?utf-8?B?cGlFeEpXUmNTUkNFbCtKT3hrQU14dXRHM05aWVFYc2F4enhwWnpMQjd1VnZo?=
 =?utf-8?B?RVcxcHI2YzhLelRuKzV3c3dEVDg5a2pnQ2N4Y3h5OFR2ZElMRFhXLzFIdmlF?=
 =?utf-8?B?Yk9CN2hheEtnYzZteEdZYnRUOTEyd0IwYmkxR3RqVXNEdnc3b0JXSkJjOTFI?=
 =?utf-8?B?ZVlJRk5CYS9WTFdzZHZaSkxJdVdCTVZ5elFoWTQ5ZmZ2dVNhY2FiTnBWZktJ?=
 =?utf-8?B?dFJkcGE2UFYzdlJHdEZ6VVBJNk1FK1F6SHg5c2pGQ3VxSG1mQlVISTNITE5J?=
 =?utf-8?B?Y2x6ZFNNcjBZNWcvdy9OeDVEK1ppTmxyaW1SaUwvT0M5VzZzZTdPbDNxcGV0?=
 =?utf-8?B?REtWYWlvMW5hU1B3T0htMk1leEc0Y3UxQ0FGOVgwSGxENjRVTS8vSjYzVlhN?=
 =?utf-8?B?czJYNElQTnNLNnh4OTNuSk5KRVVnV1ErMEpDMlNIV2M0UWpCbUk3Mm0wQmZn?=
 =?utf-8?B?dmVTa1MwbXY4SGNtcjhDRTBGRExsS2Z2aENQclZlSDdHWUp1QmU2Rm5IQm9k?=
 =?utf-8?B?VUVsZ3U4a2tVM01vNEJKZXdiMzVrbnUxQ3FOMWVqY1MyUDE1ZWVvQnp5NGsw?=
 =?utf-8?B?ZGtHRGp3ZUlCNVJKcmw3SjFMbU5EYjVmbHpSbG5xVDhoQ1drL0ZtUU5Va055?=
 =?utf-8?B?eU5IYUc2QWZucWFvb3d4YUhFOHlHRUpDcXpER0ZNYXJOaWZVUjcrNFFXUHJh?=
 =?utf-8?B?ZSsrYUNiLysxUjJHVC9oMG9JajhUSGdMc1l2V1ArUC9RKzJBSkpFTkw3SElj?=
 =?utf-8?B?S0JvNS9BNjFncWtrZmVZcEJJN1FoaHRNaTE5OWdhUUxESk5zdzZkbmx5V2pk?=
 =?utf-8?B?ZEtjYzBiNXIrVGx1WGhjT1pSeExDWXZ2WktZcWNSQk0vOFg1T3dueGR1RE9N?=
 =?utf-8?Q?vvNNoQEk1jUaCFKvcsv3TAg+RpCBSuiVOgy+kWi?=
Content-ID: <9527976352521042B6E4A04A608B8B9E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77373543-5365-4973-81d8-08d951d9edad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 15:11:08.6040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmhwHxjfk8eSsmOPXaYMB95ZXQ9/yy/u3lwGWNrxXVuAzZofUW4f4XFlj0nlHno4FOvvMaMf7BYuNFfHQa5dpMgdjprC054xj/MCDlkhbLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-Mailman-Approved-At: Wed, 28 Jul 2021 17:52:02 +0000
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
Cc: airlied@linux.ie, liviu.dudau@arm.com, stefan@agner.ch,
 amd-gfx@lists.freedesktop.org, anitha.chrisanthus@intel.com,
 patrik.r.jakobsson@gmail.com, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, daniel@ffwll.ch, edmund.j.dea@intel.com,
 s.hauer@pengutronix.de, alison.wang@nxp.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, dri-devel@lists.freedesktop.org, sean@poorly.run,
 linux-arm-kernel@lists.infradead.org, tomba@kernel.org, bbrezillon@kernel.org,
 jyri.sarha@iki.fi, Nicolas.Ferre@microchip.com, christian.koenig@amd.com,
 robdclark@gmail.com, kernel@pengutronix.de, alexander.deucher@amd.com,
 shawnguo@kernel.org, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/28/21 7:00 AM, Sam Ravnborg wrote:
> [You don't often get email from sam@ravnborg.org. Learn why this is important at http://aka.ms/LearnAboutSenderIdentification.]
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi Dan,
> 
> I hope you can fine to test this patch from Thomas.
> If this works then we can forget about my attempt to do the same.

I'll test this as soon as I can and let you know.

Thanks,
Dan
> 
> Hi Thomas,
> 
> IRQ_NOTCONNECTED check seems redundant, as mentioned in another patch
> already.
> 
> With that considered:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> We shall wait for testing from Dan before you apply it as I had made a
> similar patch that failed to work. I assume my patch was buggy but I
> prefer to be sure.
> 
>          Sam
> 
> On Tue, Jul 27, 2021 at 08:27:10PM +0200, Thomas Zimmermann wrote:
>> Drop the DRM IRQ midlayer in favor of Linux IRQ interfaces. DRM's
>> IRQ helpers are mostly useful for UMS drivers. Modern KMS drivers
>> don't benefit from using it. DRM IRQ callbacks are now being called
>> directly or inlined.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 85 ++++++++++++--------
>>   1 file changed, 52 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> index f09b6dd8754c..cfa8c2c9c8aa 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> @@ -22,7 +22,6 @@
>>   #include <drm/drm_fb_helper.h>
>>   #include <drm/drm_gem_cma_helper.h>
>>   #include <drm/drm_gem_framebuffer_helper.h>
>> -#include <drm/drm_irq.h>
>>   #include <drm/drm_probe_helper.h>
>>   #include <drm/drm_vblank.h>
>>
>> @@ -557,6 +556,56 @@ static irqreturn_t atmel_hlcdc_dc_irq_handler(int irq, void *data)
>>        return IRQ_HANDLED;
>>   }
>>
>> +static void atmel_hlcdc_dc_irq_postinstall(struct drm_device *dev)
>> +{
>> +     struct atmel_hlcdc_dc *dc = dev->dev_private;
>> +     unsigned int cfg = 0;
>> +     int i;
>> +
>> +     /* Enable interrupts on activated layers */
>> +     for (i = 0; i < ATMEL_HLCDC_MAX_LAYERS; i++) {
>> +             if (dc->layers[i])
>> +                     cfg |= ATMEL_HLCDC_LAYER_STATUS(i);
>> +     }
>> +
>> +     regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IER, cfg);
>> +}
>> +
>> +static void atmel_hlcdc_dc_irq_disable(struct drm_device *dev)
>> +{
>> +     struct atmel_hlcdc_dc *dc = dev->dev_private;
>> +     unsigned int isr;
>> +
>> +     regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IDR, 0xffffffff);
>> +     regmap_read(dc->hlcdc->regmap, ATMEL_HLCDC_ISR, &isr);
>> +}
>> +
>> +static int atmel_hlcdc_dc_irq_install(struct drm_device *dev, unsigned int irq)
>> +{
>> +     int ret;
>> +
>> +     if (irq == IRQ_NOTCONNECTED)
>> +             return -ENOTCONN;
>> +
>> +     atmel_hlcdc_dc_irq_disable(dev);
>> +
>> +     ret = request_irq(irq, atmel_hlcdc_dc_irq_handler, 0, dev->driver->name, dev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     atmel_hlcdc_dc_irq_postinstall(dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static void atmel_hlcdc_dc_irq_uninstall(struct drm_device *dev)
>> +{
>> +     struct atmel_hlcdc_dc *dc = dev->dev_private;
>> +
>> +     atmel_hlcdc_dc_irq_disable(dev);
>> +     free_irq(dc->hlcdc->irq, dev);
>> +}
>> +
>>   static const struct drm_mode_config_funcs mode_config_funcs = {
>>        .fb_create = drm_gem_fb_create,
>>        .atomic_check = drm_atomic_helper_check,
>> @@ -647,7 +696,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>        drm_mode_config_reset(dev);
>>
>>        pm_runtime_get_sync(dev->dev);
>> -     ret = drm_irq_install(dev, dc->hlcdc->irq);
>> +     ret = atmel_hlcdc_dc_irq_install(dev, dc->hlcdc->irq);
>>        pm_runtime_put_sync(dev->dev);
>>        if (ret < 0) {
>>                dev_err(dev->dev, "failed to install IRQ handler\n");
>> @@ -676,7 +725,7 @@ static void atmel_hlcdc_dc_unload(struct drm_device *dev)
>>        drm_mode_config_cleanup(dev);
>>
>>        pm_runtime_get_sync(dev->dev);
>> -     drm_irq_uninstall(dev);
>> +     atmel_hlcdc_dc_irq_uninstall(dev);
>>        pm_runtime_put_sync(dev->dev);
>>
>>        dev->dev_private = NULL;
>> @@ -685,40 +734,10 @@ static void atmel_hlcdc_dc_unload(struct drm_device *dev)
>>        clk_disable_unprepare(dc->hlcdc->periph_clk);
>>   }
>>
>> -static int atmel_hlcdc_dc_irq_postinstall(struct drm_device *dev)
>> -{
>> -     struct atmel_hlcdc_dc *dc = dev->dev_private;
>> -     unsigned int cfg = 0;
>> -     int i;
>> -
>> -     /* Enable interrupts on activated layers */
>> -     for (i = 0; i < ATMEL_HLCDC_MAX_LAYERS; i++) {
>> -             if (dc->layers[i])
>> -                     cfg |= ATMEL_HLCDC_LAYER_STATUS(i);
>> -     }
>> -
>> -     regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IER, cfg);
>> -
>> -     return 0;
>> -}
>> -
>> -static void atmel_hlcdc_dc_irq_uninstall(struct drm_device *dev)
>> -{
>> -     struct atmel_hlcdc_dc *dc = dev->dev_private;
>> -     unsigned int isr;
>> -
>> -     regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IDR, 0xffffffff);
>> -     regmap_read(dc->hlcdc->regmap, ATMEL_HLCDC_ISR, &isr);
>> -}
>> -
>>   DEFINE_DRM_GEM_CMA_FOPS(fops);
>>
>>   static const struct drm_driver atmel_hlcdc_dc_driver = {
>>        .driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>> -     .irq_handler = atmel_hlcdc_dc_irq_handler,
>> -     .irq_preinstall = atmel_hlcdc_dc_irq_uninstall,
>> -     .irq_postinstall = atmel_hlcdc_dc_irq_postinstall,
>> -     .irq_uninstall = atmel_hlcdc_dc_irq_uninstall,
>>        DRM_GEM_CMA_DRIVER_OPS,
>>        .fops = &fops,
>>        .name = "atmel-hlcdc",
>> --
>> 2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
