Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F406CC4743F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1AF611C0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1AF611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBAE6E0F7;
	Mon,  7 Jun 2021 03:41:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1B86E0F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 03:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP/l1j785Zyt8+AtdNqi5B8W7a/DU8db3ivRfv5qMBgD/5jkIx7rlbpkK8UBIk806RDAP2JgBjU+Oj0Z9y9VlNUHzegnJXiOd+zXqvhgxEfihOO3yEGoqZtWu0xeDO4dzRa8604xFxh7+Y5iXffWBMwwKKv/VKhXm1tBnbLBZz3cJ5C1KO/OUEurkhiijDJYx/+GHf/abnux9CqWvz3m0+AxvcvdOFrZ/oWsmENg1+Y5lOi637fIrko6IavvBr6D/cyK6+w0BOieQM2GK0+vtiKNtS78QBRAy5p8VsX0Yhq0qyFxB0AxQYljc1jjLPddkcgYwCQZ6vx9d8TMD+hU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS1VnUfywRPoE4EuuAQtgS1zMnSNPxvOJSGUdlXfNso=;
 b=g+QCgm2vL49KXeT/ArT+XQ0oL97YaRIejpCOak5Sf8KfYC+1AnE23H4SMbwymfYwe111S/h8bph6dBczjd2v7bHT2g63zICv2baY7YtEk+G7AgNTYSr1Ug3iq5B9/kcNXPdQ/RKS5mfZ/YZKGjtj3uyh0XaTVEEKNLcYf6wTwIR0KueQ9ZyNiC8OBcoi+Y2lznLOnp/fW1XmjsxKoA0NQ7ptrYwjY0/oQ7oo3AmFKW2DfHOZv6RojPfOer/cXw4QxhjKBMX1h9N4hnPM/ewUyVPnxwq/+jz2KGfJ9L2EnBGsGfizwFWsloew6K6Nt83EHUiLJEmdT8eOvTSVn8jImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS1VnUfywRPoE4EuuAQtgS1zMnSNPxvOJSGUdlXfNso=;
 b=jhZiwTpB2RzFdqyhFC+41YEkOpPnt7Ms3zEWKuZQk6+P9RThpoLIzncudmRZ5sAe6CUF0DA006R+Pf5HVRcYsgUHqO+VUE7ZXuwBAuOtaj5iaBkb1NQSR9JmV1wVsIi3kdM6FO3Ex2qB5aYoSU4Z6K2azYOhp3FhRaSj8XzH3e8=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 03:41:49 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4195.029; Mon, 7 Jun 2021
 03:41:49 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Topic: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Index: AQHXW08M1JfznG+kmEWWw0MPaZzE9g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 7 Jun 2021 03:41:49 +0000
Message-ID: <MW2PR12MB468466F59A1FC2E78854D5D4FD389@MW2PR12MB4684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b089496-d271-4eb4-48cd-08d929662eb2
x-ms-traffictypediagnostic: MW2PR12MB2539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB2539AE6B3DE265F25BF63DAFFD389@MW2PR12MB2539.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKcuCo2YVwncwu/mxMAcOyxfsFopPdJQeC3ZBxeh+VeMXidI9OMuxTM2lQy4O0yrjbXRVgRR7T809aTQEsoQAEuYYiHudUX/keI+ZSGRJMPzdfE5ZWuCr1bmNuWX3aFLwnB01JplKmO3tl8SSZrNjQYxwyHJueSMKe1MhG+p42romNw3HoQFvEEtXdTqjFooeYutJ187izS9uOseTIz1yJPrg2mqAMtLWCU67Alkj6oAKLolrXfWtiFiFbxVLSe1gjh7ClZRpbitYSFNbzKKk+IFEI9pQkFVE+ZiGhTpXFyG5g45h0mdGdLjPEBbPHwYrjgbZlLIQOUtunr9MsH/N072HyExm3dcLxDZ03RQgHX09OMjsQ8BLDm0xh9YRj3S5/Zxew+rYg2iZSbo0XMsPh2GC1vHpYeR3eXkieDZn83CSx7bBP74NXLby5o6lEi05IMg8i+eMlkFSnzLOJwXk6FjPxpgGq42bWFylMSeLmX77lC+/iEK23Hz3g89sKZR8dW7SbYkOWjGTWjaO5uTVmDAb3x9eXj+BqMLqI+XT51fk2HbOdvSFfQbD81Kp1lkpJhV6jdo4yhSMl981g9iHGJqjL0Zl7RgQMEa1r8eYaI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(66476007)(122000001)(66556008)(64756008)(6506007)(66946007)(110136005)(76116006)(83380400001)(5660300002)(316002)(2906002)(38100700002)(478600001)(186003)(52536014)(26005)(7696005)(66446008)(55016002)(9686003)(8676002)(8936002)(558084003)(86362001)(15650500001)(71200400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?W+kL7C310QGs0DaYxqGRVrzU2wOgH5lz43jljwVjC2nZOAaL7Yhr9kKiFcuD?=
 =?us-ascii?Q?hd6jnKyWsObHdorowwMwEQS9sYxtRCc5oFxP25sbrOYjv9/v9iXo2iLxGHRg?=
 =?us-ascii?Q?FRRyb7aqQgHJGD4zUf7/nqdBg+CpqFZ47S2NxXqFExfUhyIKEc+kRbWmT4mX?=
 =?us-ascii?Q?o4VMwDWIcFkTk+Aup8eVRHiWV2gf1d9aAN7EOKEsJLIsKh6zdXM87cFVgePW?=
 =?us-ascii?Q?3PimPDt4ftvC1QeKC0AKlfm+x8qv0GdF0Gun0rh9opM4niyOa3CVy/Rvdav/?=
 =?us-ascii?Q?v7cTi4CQnAtsfHrVLN/WomJaX0Rl83HGwPp8w93yb6jBygB0hu9eznWcvtVv?=
 =?us-ascii?Q?ngSxZ2E/BTPY7MEJ5YnOs92WQD8TRgIZyySYaWfZNgSA7NKeT1qwYLVZIip+?=
 =?us-ascii?Q?IdwzFFBwfUuuEqtJan6fCBXw8FFUjWrBnOtHyq/QLsHgJWMJiyIQ5rQpvEG1?=
 =?us-ascii?Q?ZgA1tnAA8baVrmibbpWGrsdGgr+8sDaNDXOEBZ4bxlmfGD5ikoY/ka6Ro/wV?=
 =?us-ascii?Q?1NrokaP7aW8UION32nvX2qTo/0t/diIq1Uhqc6d9wz3V56AKOXdALZcRQpQe?=
 =?us-ascii?Q?NzvFpMfSHcf4XbcarNy9Pl8Ivo86yu+f+sRQ9mqX4290WodFeE3gPLq7SEUA?=
 =?us-ascii?Q?CT28dd8t2mWe0iEgyqy7ulXcFCRn/8Rfikr1Urxx4eea4Pw4RcBKe+1Ehrnu?=
 =?us-ascii?Q?l6m+ps9zceEQOYX9twvaRJWbneHybD1WmyYEOD/XKxv0dKuBrUZqIK37vyGO?=
 =?us-ascii?Q?j0YjK6Zt3iw/MlYjHcaY5tWD3/g2KrgGWbigzTv+QY4X+wVZ09s2I7YAyLWx?=
 =?us-ascii?Q?bY84UWjGz5VJtzO94NUcT2Glcr5cU+qKi77oNH0PeA3hGKLF3FVof2042/kw?=
 =?us-ascii?Q?4FtDcxELmWrOoVUrY05jUxozDtBuEujK2seTOaCXqJsrrgsxPnLRrGlk77bU?=
 =?us-ascii?Q?TXhxZ4153nYxm59aomZ2km5ASVwPLF6UWGLqp7+dDo0+IccDnbo93H05dMDz?=
 =?us-ascii?Q?h08Dl4K8nPglurki9QMXPNIvIAik1dmwdFwmirLW0JFCXk3kMmIpRbwSUBJ2?=
 =?us-ascii?Q?LY0Bb0rIojK/W/xs4OMWz2UK3qDo8KUMZwSQ02C8xoA9/EA88y/iTsQfjHyY?=
 =?us-ascii?Q?lx4Mv+waX2a+ecBB9nXL7TUtYtxph/VDAu01u7WkuzY4OF6IE2TpJsTXzNs1?=
 =?us-ascii?Q?33OoIMibK0AznQ/sXnhkUiHrSiS4sqxPkWCP1S9l6vofNgx7zTd/gNwWjAXj?=
 =?us-ascii?Q?G5OigsDxXJCWC7FQsNL1kYXikQJ90M5pOWxQ2VzZe/mslTl6NHvGAGHo23T2?=
 =?us-ascii?Q?PvBf2qEwMm91un4bbYaZKgZD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b089496-d271-4eb4-48cd-08d929662eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:41:49.5205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLtDG6ImrKDDmUtESmAcbqca+gwUyWEyOr0sO0eVhxSrOtqkBcsRuFi+0bVfFcDKQFphfzprU1bLMXExexSo3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Zhu, Changfeng would like to recall the message, "[PATCH] drm/amdgpu: Update psp fw attestation support list".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
