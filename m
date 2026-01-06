Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4F5C2A073
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 07:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13C510E0A7;
	Tue,  6 Jan 2026 07:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="02oD88xC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EuqUx8Br";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="02oD88xC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EuqUx8Br";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2092C10E0A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 07:04:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC8C95BCC4;
 Tue,  6 Jan 2026 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767683075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ENBZMJ5eKWNdw8VNIYSLbmPTayj5BgVkHTNw1ev+ZI=;
 b=02oD88xCQUQHtkuC6uiCgt3pks07SO9Zztbh5IIC6bxnF2K/AaLQqOc/cpByw/lMvrVcc3
 DZ+6MEjRRnM7RAXTUOUnZMR6rJseEK6o1W9eJh+HPqLxpoV7DDVdFA+UjS/OCNbmfQe46/
 81PKMHsR6RcC2KJmLxWKUswnNMOikoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767683075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ENBZMJ5eKWNdw8VNIYSLbmPTayj5BgVkHTNw1ev+ZI=;
 b=EuqUx8BrSZzeROEVihR7N7z81ettBiGvcPzavYR82Ge4wkJ4N0R8EX1qWuOtBvF5LG1nbu
 dvA2aoLuBIXOiKAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=02oD88xC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EuqUx8Br
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767683075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ENBZMJ5eKWNdw8VNIYSLbmPTayj5BgVkHTNw1ev+ZI=;
 b=02oD88xCQUQHtkuC6uiCgt3pks07SO9Zztbh5IIC6bxnF2K/AaLQqOc/cpByw/lMvrVcc3
 DZ+6MEjRRnM7RAXTUOUnZMR6rJseEK6o1W9eJh+HPqLxpoV7DDVdFA+UjS/OCNbmfQe46/
 81PKMHsR6RcC2KJmLxWKUswnNMOikoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767683075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ENBZMJ5eKWNdw8VNIYSLbmPTayj5BgVkHTNw1ev+ZI=;
 b=EuqUx8BrSZzeROEVihR7N7z81ettBiGvcPzavYR82Ge4wkJ4N0R8EX1qWuOtBvF5LG1nbu
 dvA2aoLuBIXOiKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 961073EA63;
 Tue,  6 Jan 2026 07:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wBYVIwO0XGkxagAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 06 Jan 2026 07:04:35 +0000
Message-ID: <652a40bd-2792-4a88-b3b3-6d56e1a14b5d@suse.de>
Date: Tue, 6 Jan 2026 08:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fb-helper: Fix vblank timeout during suspend/reset
To: Chengjun Yao <Chengjun.Yao@amd.com>, Aurabindo.Pillai@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20251215081822.432005-1-Chengjun.Yao@amd.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20251215081822.432005-1-Chengjun.Yao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-4.41 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_BASE64_TEXT(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,amd.com:email,suse.de:email,suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC8C95BCC4
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGksDQoNCnRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KDQpBbSAxNS4xMi4yNSB1bSAwOToxOCBz
Y2hyaWViIENoZW5nanVuIFlhbzoNCj4gRHVyaW5nIEdQVSByZXNldCwgVkJsYW5rIGludGVy
cnVwdHMgYXJlIGRpc2FibGVkIHdoaWNoIGNhdXNlcw0KPiBkcm1fZmJfaGVscGVyX2ZiX2Rp
cnR5KCkgdG8gd2FpdCBmb3IgVkJsYW5rIHRpbWVvdXQuIFRoaXMgd2lsbCBjcmVhdGUNCj4g
Y2FsbCB0cmFjZXMgbGlrZSAoc2VlbiBvbiBhbiBSWDc5MDAgc2VyaWVzIGRHUFUpOg0KPg0K
PiBbICAxMDEuMzEzNjQ2XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0N
Cj4gWyAgMTAxLjMxMzY0OF0gYW1kZ3B1IDAwMDA6MDM6MDAuMDogW2RybV0gdmJsYW5rIHdh
aXQgdGltZWQgb3V0IG9uIGNydGMgMA0KPiBbICAxMDEuMzEzNjU3XSBXQVJOSU5HOiBDUFU6
IDAgUElEOiA0NjEgYXQgZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYzoxMzIwIGRybV93
YWl0X29uZV92YmxhbmsrMHgxNzYvMHgyMjANCj4gWyAgMTAxLjMxMzY2M10gTW9kdWxlcyBs
aW5rZWQgaW46IGFtZGdwdSBhbWR4Y3AgZHJtX3BhbmVsX2JhY2tsaWdodF9xdWlya3MgZ3B1
X3NjaGVkIGRybV9idWRkeSBkcm1fdHRtX2hlbHBlciB0dG0gZHJtX2V4ZWMgZHJtX3N1YmFs
bG9jX2hlbHBlciBkcm1fZGlzcGxheV9oZWxwZXIgY2VjIHJjX2NvcmUgaTJjX2FsZ29fYml0
IG5mX2Nvbm50cmFja19uZXRsaW5rIHh0X25hdCB4dF90Y3B1ZHAgdmV0aCB4dF9jb25udHJh
Y2sgeHRfTUFTUVVFUkFERSBicmlkZ2Ugc3RwIGxsYyB4ZnJtX3VzZXIgeGZybV9hbGdvIHh0
X3NldCBpcF9zZXQgbmZ0X2NoYWluX25hdCBuZl9uYXQgbmZfY29ubnRyYWNrIG5mX2RlZnJh
Z19pcHY2IG5mX2RlZnJhZ19pcHY0IHh0X2FkZHJ0eXBlIG5mdF9jb21wYXQgeF90YWJsZXMg
bmZfdGFibGVzIG92ZXJsYXkgcXJ0ciBzdW5ycGMgc25kX2hkYV9jb2RlY19hbGM4ODIgc25k
X2hkYV9jb2RlY19yZWFsdGVrX2xpYiBzbmRfaGRhX2NvZGVjX2dlbmVyaWMgc25kX2hkYV9j
b2RlY19hdGloZG1pIHNuZF9oZGFfY29kZWNfaGRtaSBzbmRfaGRhX2ludGVsIHNuZF9oZGFf
Y29kZWMgc25kX2hkYV9jb3JlIHNuZF9pbnRlbF9kc3BjZmcgc25kX2ludGVsX3Nkd19hY3Bp
IHNuZF9od2RlcCBzbmRfcGNtIGFtZF9hdGwgaW50ZWxfcmFwbF9tc3Igc25kX3NlcV9taWRp
IGludGVsX3JhcGxfY29tbW9uIGFzdXNfZWNfc2Vuc29ycyBzbmRfc2VxX21pZGlfZXZlbnQg
c25kX3Jhd21pZGkgc25kX3NlcSBlZWVwY193bWkgc25kX3NlcV9kZXZpY2UgZWRhY19tY2Vf
YW1kIGFzdXNfd21pIHBvbHl2YWxfY2xtdWxuaSBnaGFzaF9jbG11bG5pX2ludGVsIHNuZF90
aW1lciBwbGF0Zm9ybV9wcm9maWxlIGFlc25pX2ludGVsIHdtaV9ibW9mIHNwYXJzZV9rZXlt
YXAgam95ZGV2IHNuZCByYXBsIGlucHV0X2xlZHMgaTJjX3BpaXg0IHNvdW5kY29yZSBjY3Ag
azEwdGVtcCBpMmNfc21idXMgZ3Bpb19hbWRwdCBtYWNfaGlkIGJpbmZtdF9taXNjIHNjaF9m
cV9jb2RlbCBtc3IgcGFycG9ydF9wYyBwcGRldiBscCBwYXJwb3J0DQo+IFsgIDEwMS4zMTM3
NDVdICBlZmlfcHN0b3JlIG5mbmV0bGluayBkbWlfc3lzZnMgYXV0b2ZzNCBoaWRfZ2VuZXJp
YyB1c2JoaWQgaGlkIHI4MTY5IHJlYWx0ZWsgYWhjaSBsaWJhaGNpIHZpZGVvIHdtaQ0KPiBb
ICAxMDEuMzEzNzYwXSBDUFU6IDAgVUlEOiAwIFBJRDogNDYxIENvbW06IGt3b3JrZXIvMDoy
IE5vdCB0YWludGVkIDYuMTguMC1yYzYtMTc0NDAzYjNiOTIwICMxIFBSRUVNUFQodm9sdW50
YXJ5KQ0KPiBbICAxMDEuMzEzNzYzXSBIYXJkd2FyZSBuYW1lOiBBU1VTIFN5c3RlbSBQcm9k
dWN0IE5hbWUvVFVGIEdBTUlORyBYNjcwRS1QTFVTLCBCSU9TIDA4MjEgMTEvMTUvMjAyMg0K
PiBbICAxMDEuMzEzNzY1XSBXb3JrcXVldWU6IGV2ZW50cyBkcm1fZmJfaGVscGVyX2RhbWFn
ZV93b3JrDQo+IFsgIDEwMS4zMTM3NjldIFJJUDogMDAxMDpkcm1fd2FpdF9vbmVfdmJsYW5r
KzB4MTc2LzB4MjIwDQo+IFsgIDEwMS4zMTM3NzJdIENvZGU6IDdjIDI0IDA4IDRjIDhiIDc3
IDUwIDRkIDg1IGY2IDBmIDg0IGExIDAwIDAwIDAwIGU4IDJmIDExIDAzIDAwIDQ0IDg5IGU5
IDRjIDg5IGYyIDQ4IGM3IGM3IGQwIGFkIDBkIGE4IDQ4IDg5IGM2IGU4IDJhIGUwIDRhIGZm
IDwwZj4gMGIgZTkgZjIgZmUgZmYgZmYgNDggODUgZmYgNzQgMDQgNGMgOGIgNjcgMDggNGQg
OGIgNmMgMjQgNTAgNGQNCj4gWyAgMTAxLjMxMzc3NF0gUlNQOiAwMDE4OmZmZmZjOTljMDBk
NDdkNjggRUZMQUdTOiAwMDAxMDI0Ng0KPiBbICAxMDEuMzEzNzc3XSBSQVg6IDAwMDAwMDAw
MDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAyMDAwMzhhIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0K
PiBbICAxMDEuMzEzNzc4XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAw
MDAwMDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAxMDEuMzEzNzc5XSBSQlA6IGZm
ZmZjOTljMDBkNDdkYzAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAw
MDAwMA0KPiBbICAxMDEuMzEzNzgxXSBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAw
MDAwMDAwMDAwMDAwIFIxMjogZmZmZjg5NDhjNDI4MDAxMA0KPiBbICAxMDEuMzEzNzgyXSBS
MTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiBmZmZmODk0ODgzMjYzYTUwIFIxNTogZmZmZjg5
NDg4YzM4NDgzMA0KPiBbICAxMDEuMzEzNzg0XSBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAw
MCkgR1M6ZmZmZjg5NTQyNDY5MjAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+
IFsgIDEwMS4zMTM3ODVdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAw
MDAwODAwNTAwMzMNCj4gWyAgMTAxLjMxMzc4N10gQ1IyOiAwMDAwNzc3MzY1MGVlMjAwIENS
MzogMDAwMDAwMDU4OGU0MDAwMCBDUjQ6IDAwMDAwMDAwMDBmNTBlZjANCj4gWyAgMTAxLjMx
Mzc4OF0gUEtSVTogNTU1NTU1NTQNCj4gWyAgMTAxLjMxMzc5MF0gQ2FsbCBUcmFjZToNCj4g
WyAgMTAxLjMxMzc5MV0gIDxUQVNLPg0KPiBbICAxMDEuMzEzNzk1XSAgPyBfX3BmeF9hdXRv
cmVtb3ZlX3dha2VfZnVuY3Rpb24rMHgxMC8weDEwDQo+IFsgIDEwMS4zMTM4MDBdICBkcm1f
Y3J0Y193YWl0X29uZV92YmxhbmsrMHgxNy8weDMwDQo+IFsgIDEwMS4zMTM4MDJdICBkcm1f
Y2xpZW50X21vZGVzZXRfd2FpdF9mb3JfdmJsYW5rKzB4NjEvMHg4MA0KPiBbICAxMDEuMzEz
ODA1XSAgZHJtX2ZiX2hlbHBlcl9kYW1hZ2Vfd29yaysweDQ2LzB4MWEwDQo+IFsgIDEwMS4z
MTM4MDhdICBwcm9jZXNzX29uZV93b3JrKzB4MWExLzB4M2YwDQo+IFsgIDEwMS4zMTM4MTJd
ICB3b3JrZXJfdGhyZWFkKzB4MmJhLzB4M2QwDQo+IFsgIDEwMS4zMTM4MTZdICBrdGhyZWFk
KzB4MTA3LzB4MjIwDQo+IFsgIDEwMS4zMTM4MThdICA/IF9fcGZ4X3dvcmtlcl90aHJlYWQr
MHgxMC8weDEwDQo+IFsgIDEwMS4zMTM4MjFdICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEw
DQo+IFsgIDEwMS4zMTM4MjNdICByZXRfZnJvbV9mb3JrKzB4MjAyLzB4MjMwDQo+IFsgIDEw
MS4zMTM4MjZdICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+IFsgIDEwMS4zMTM4Mjhd
ICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gWyAgMTAxLjMxMzgzNF0gIDwvVEFT
Sz4NCj4gWyAgMTAxLjMxMzgzNV0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBd
LS0tDQo+DQo+IENhbmNlbCBwZW5kaW5nIGRhbWFnZSB3b3JrIHN5bmNocm9ub3VzbHkgYmVm
b3JlIGNvbnNvbGVfbG9jaygpIHRvIGVuc3VyZQ0KPiBhbnkgaW4tZmxpZ2h0IGZyYW1lYnVm
ZmVyIGRhbWFnZSBvcGVyYXRpb25zIGNvbXBsZXRlIGJlZm9yZSBzdXNwZW5zaW9uLg0KPg0K
PiBBbHNvIGNoZWNrIGZvciBGQklORk9fU1RBVEVfUlVOTklORyBpbiBkcm1fZmJfaGVscGVy
X2RhbWFnZV93b3JrKCkgdG8NCj4gYXZvaWQgZXhlY3V0aW5nIGRhbWFnZSB3b3JrIGlmIGl0
IGlzIHJlc2NoZWR1bGVkIHdoaWxlIHRoZSBkZXZpY2UgaXMgc3VzcGVuZGVkLg0KPg0KPiBG
aXhlczogZDhjNGJkZGNkOGJjICgiZHJtL2ZiLWhlbHBlcjogU3luY2hyb25pemUgZGlydHkg
d29ya2VyIHdpdGggdmJsYW5rIikNCj4gU2lnbmVkLW9mZi1ieTogQXVyYWJpbmRvIFBpbGxh
aSA8YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuZ2p1
biBZYW8gPENoZW5nanVuLllhb0BhbWQuY29tPg0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIFpp
bW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2RybV9mYl9oZWxwZXIuYyB8IDEwICsrKysrKysrKysNCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9mYl9oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZmJfaGVscGVyLmMN
Cj4gaW5kZXggYzAzNDNlYzE2YTU3Li4xOTljY2ExYjViZGQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fZmJfaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2RybV9mYl9oZWxwZXIuYw0KPiBAQCAtNDAyLDYgKzQwMiw5IEBAIHN0YXRpYyB2b2lkIGRy
bV9mYl9oZWxwZXJfZGFtYWdlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAg
IHsNCj4gICAJc3RydWN0IGRybV9mYl9oZWxwZXIgKmhlbHBlciA9IGNvbnRhaW5lcl9vZih3
b3JrLCBzdHJ1Y3QgZHJtX2ZiX2hlbHBlciwgZGFtYWdlX3dvcmspOw0KPiAgIA0KPiArCWlm
IChoZWxwZXItPmluZm8tPnN0YXRlICE9IEZCSU5GT19TVEFURV9SVU5OSU5HKQ0KPiArCQly
ZXR1cm47DQo+ICsNCj4gICAJZHJtX2ZiX2hlbHBlcl9mYl9kaXJ0eShoZWxwZXIpOw0KPiAg
IH0NCj4gICANCj4gQEAgLTc5NCw2ICs3OTcsMTMgQEAgdm9pZCBkcm1fZmJfaGVscGVyX3Nl
dF9zdXNwZW5kX3VubG9ja2VkKHN0cnVjdCBkcm1fZmJfaGVscGVyICpmYl9oZWxwZXIsDQo+
ICAgCQlpZiAoZmJfaGVscGVyLT5pbmZvLT5zdGF0ZSAhPSBGQklORk9fU1RBVEVfUlVOTklO
RykNCj4gICAJCQlyZXR1cm47DQo+ICAgDQo+ICsJCS8qDQo+ICsJCSAqIENhbmNlbCBwZW5k
aW5nIGRhbWFnZSB3b3JrLiBEdXJpbmcgR1BVIHJlc2V0LCBWQmxhbmsNCj4gKwkJICogaW50
ZXJydXB0cyBhcmUgZGlzYWJsZWQgYW5kIGRybV9mYl9oZWxwZXJfZmJfZGlydHkoKQ0KPiAr
CQkgKiB3b3VsZCB3YWl0IGZvciBWQmxhbmsgdGltZW91dCBvdGhlcndpc2UuDQo+ICsJCSAq
Lw0KPiArCQljYW5jZWxfd29ya19zeW5jKCZmYl9oZWxwZXItPmRhbWFnZV93b3JrKTsNCj4g
Kw0KPiAgIAkJY29uc29sZV9sb2NrKCk7DQo+ICAgDQo+ICAgCX0gZWxzZSB7DQoNCi0tIA0K
LS0NClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHIuIDE0NiwgOTA0
NjEgTsO8cm5iZXJnLCBHZXJtYW55LCB3d3cuc3VzZS5jb20NCkdGOiBKb2NoZW4gSmFzZXIs
IEFuZHJldyBNY0RvbmFsZCwgV2VybmVyIEtub2JsaWNoLCAoSFJCIDM2ODA5LCBBRyBOw7xy
bmJlcmcpDQoNCg0K
